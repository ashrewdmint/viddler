module Riddler
  class Playlist
    attr_reader :id, :name, :type, :videos, :session
    
    def initialize(session=nil, response={})
      @session = session || Session.new
      self.populate_from_response!(response)
    end
    
    def self.create!(session, attrs)
      response = session.client.post("viddler.playlists.create", attrs)
      self.new_with_proper_class(session, response)
    end
    
    def self.destroy(session, playlist_id)
      session.client.post("viddler.playlists.delete", :playlist_id => playlist_id)
      true
    end
    
    def self.find(session, id, options={})
      response = session.client.get("viddler.playlists.getDetails", {:playlist_id => id}.merge(options))
      self.new_with_proper_class(session, response)
    end
    
    def self.set(session, id, options={})
      response = session.client.post("viddler.playlists.setDetails", {:playlist_id => id}.merge(options))
      self.new_with_proper_class(session, response)
    end
    
    def self.find_all_by_username(session, username, options={})
      response = session.client.get("viddler.playlists.getByUser", {:username => username}.merge(options))
      Riddler::PlaylistList.new(session, response)
    end
    
    def self.add_video(session, playlist_id, video_id, options={})
      response = session.client.post("viddler.playlists.addVideo", {
        :playlist_id => playlist_id,
        :video_id    => video_id
      }.merge(options))
      
      self.new_with_proper_class(session, response)
    end
    
    def self.move_video(session, playlist_id, from_index, to_index, options={})
      response = session.client.post("viddler.playlists.moveVideo", {
        :playlist_id => playlist_id,
        :from        => from_index,
        :to          => to_index 
      }.merge(options))
      
      self.new_with_proper_class(session, response)
    end
    
    def self.remove_video(session, playlist_id, position, options={})
      response = session.client.post("viddler.playlists.removeVideo", {
        :playlist_id => playlist_id,
        :position    => position
      }.merge(options))

      self.new_with_proper_class(session, response)
    end
    
    def update_attributes!(attributes)
      attributes[:playlist_id] = self.id
      populate_from_response! self.session.client.post('viddler.playlists.setDetails', attributes)
    end
    
    protected
    
    def self.new_with_proper_class(session, response)
      klass = response['list_result']['playlist']['type'] == 'smart' ? Riddler::SmartPlaylist : Riddler::RegularPlaylist
      klass.new(session, response)
    end
    
    def populate_from_response!(response)
      return unless response['list_result']
      
      if response['list_result']['playlist']
        playlist_attrs = response['list_result']['playlist']

        @id   = playlist_attrs['id']
        @name = playlist_attrs['name']
        @type = playlist_attrs['type']
        
        @videos = Riddler::VideoList.new(@session, response, 'viddler.playlists.getDetails', {
          :playlist_id => @id
        })
      end
    end
  end
end
