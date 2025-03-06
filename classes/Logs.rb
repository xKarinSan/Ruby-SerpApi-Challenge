require 'date'


"""
Method has the following:
POST -> create
GET -> retrieve
PUT -> update existing 
DELETE -> remove existing
"""
class LogItem
    def initialize(payload,method)
        @log_date = DateTime.now
        @payload = payload
        @method = method
    end
    def display_log_info
        return "- Date Logged:#{@log_date}\n- Payload:#{@payload}\n- Method:#{@method}\n\n"
    end
end

class Logger
    attr_accessor :log_storage
    def initialize
        @log_storage = []
    end
    def add_log(payload,method)
        new_log = LogItem.new(payload,method)
        @log_storage.append(new_log)
    end
    
    def display_all_logs
        @log_storage.each do |log|
            puts log.display_log_info
    end
end
end
