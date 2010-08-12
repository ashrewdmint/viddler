module Riddler
  class User
    STRING_ATTRIBUTES = [:username, :first_name, :last_name, :about_me,
                         :avatar, :homepage, :company, :gender, :city]
                        
    INT_ATTRIBUTES    = [:age, :video_upload_count, :video_watch_count,
                         :friend_count, :favourite_video_count]

    (STRING_ATTRIBUTES + INT_ATTRIBUTES).each {|a| attr_accessor a}
    
    def initialize(session, response)
      response = response['user'] if response['user']
      
      STRING_ATTRIBUTES.each do |attr|
        instance_variable_set("@#{attr.to_s}", response[attr.to_s]) if response[attr.to_s]
      end
      
      INT_ATTRIBUTES.each do |attr|
        instance_variable_set("@#{attr.to_s}", response[attr.to_s].to_i) if response[attr.to_s]
      end
    end
  end
end