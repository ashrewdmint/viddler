module Riddler
  class List < Array
    attr_accessor :session, :list_method, :list_method_options
    
    def initialize(session, list_method, list_method_options)
      @session             = session
      @list_method         = list_method
      @list_method_options = list_method_options
    end
    
    def page(page, options={})
      options = {:per_page => 10}.merge(options)
      offset  = options[:per_page]*(page-1)
      self[offset, options[:per_page]]
    end
    
    def each
      i = 0
      keep_going = true
      
      while keep_going
        if self[i].nil?
          keep_going = false
        else
          yield self[i]
          i += 1
        end
      end
    end
    
    def [](start, length=1)
      if start.is_a?(Range)
        length = start.end - start.begin + 1
        start  = start.begin
      end
      
      i   = start
      arr = []
      
      length.times do
        fetch_page(i/100+1) if super(i).nil?
        break if super(i).nil?
        
        arr << super(i) 
        i += 1
      end
      
      if length == 1
        return arr[0]
      else
        return arr
      end
    end
    
    alias_method :slice, :[]
    
    private
    
    def fetch_page(page)
      insert_response(session.client.get(list_method, list_method_options.merge(:page => page, :per_page => 100)))
    end
  end
end