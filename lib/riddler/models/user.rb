module Riddler
  class User
    extend ActiveSupport::Memoizable
    
    TYPES = ['personal', 'partner', 'business']

    STRING_ATTRIBUTES = [:username, :first_name, :last_name, :about_me,
                         :avatar, :homepage, :company, :gender, :city, :email]

    INT_ATTRIBUTES    = [:age, :video_upload_count, :video_watch_count,
                         :friend_count, :favourite_video_count]

    (STRING_ATTRIBUTES + INT_ATTRIBUTES).each {|a| attr_accessor a}

    attr_accessor :raw_response

    def initialize(session, response)
      @session = session
      
      response = response['user'] if response['user']
      self.raw_response = response

      STRING_ATTRIBUTES.each do |attr|
        instance_variable_set("@#{attr.to_s}", response[attr.to_s]) if response[attr.to_s]
      end

      INT_ATTRIBUTES.each do |attr|
        instance_variable_set("@#{attr.to_s}", response[attr.to_s].to_i) if response[attr.to_s]
      end
    end
    
    def videos(options={})
      if options[:page]
        videos = @session.client.get 'viddler.videos.getByUser', options.merge(:user => username)
        options.delete(:page)
        options.delete(:per_page)
      else
        videos = {}
      end
      
      Riddler::VideoList.new(@session, videos, 'viddler.videos.getByUser', {:user => username}.merge(options))
    end
    
    memoize :videos
    
  end
end