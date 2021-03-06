module Riddler
  class VideoList < List
    def parse_response(response)
      arr = []
      
      response['list_result']['video_list'].each do |vid|
        arr << Riddler::Video.new(session, vid)
      end
      
      return arr
    end
  end
end
