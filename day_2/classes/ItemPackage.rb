require_relative './Logs.rb'
require 'securerandom'

class ItemPackage
    attr_accessor :name
    attr_accessor :contents
    attr_accessor :status_code
    attr_accessor :recipient
    def initialize(name, contents,recipient,logger)
        @package_id = SecureRandom.hex(10)
        @name = name
        @contents = contents
        @status_code = 1
        @recipient = recipient
        @logger = logger
        puts "#{name} is created!"
    end

    def get_package_id 
        @logger.add_log({"package_id"=> @package_id},"GET")
        return @package_id
    end

    def get_recipient
        return @recipient
    end

    def check_status
        status_message = ""
        if @status_code == 1
            status_message = "Package is new!"
        elsif @status_code == 2
            status_message = "Package is being delivered"
        elsif @status_code == 3
            status_message= "Package is successfully delivered"
        else
            status_message =  "Package is not successfully delivered!!"
        end
        
        res = {
            "status_code" => @status_code,
            "message" => status_message
        }
        @logger.add_log(res,"GET")
        return res
    end

    def send_package(recipient_id)
        if recipient_id == ""
            puts "[ItemPackage][send_package] There is no recipient ID."
            @logger.add_log({"recipient_id" => recipient_id, "status_code" => @status_code},"POST")
            return -1
        end
        @recipient = recipient_id
        @status_code = 2
        puts "[ItemPackage][send_pacakge] Package is delivered."
        @logger.add_log({"recipient_id" => @recipient, "status_code" => @status_code},"POST")
        return 1
    end

    def receive_package(recipient_id)
        if recipient_id != @recipient
            @status_code = -1
            puts "[ItemPackage][receive_package] Wrong recipient."
            @logger.add_log({"recipient_id" => @recipient, "status_code" => @status_code},"GET")
            return -1
        end
        @status_code = 3
        puts "[ItemPackage][receive_package] Package succssfully received."
        @logger.add_log({"recipient_id" => @recipient, "status_code" => @status_code},"GET")
        return 1
    end

end