require 'securerandom'

class ItemPackage
    attr_accessor :name
    attr_accessor :contents
    attr_accessor :status_code
    attr_accessor :recipient
    def initialize(name, contents,recipient)
        @package_id = SecureRandom.hex(10)
        @name = name
        @contents = contents
        @status_code = 1
        @recipient = recipient
        puts "#{name} is created!"
    end
    def get_package_id 
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
        return {
            "status_code" => @status_code,
            "message" => status_message
        }
    end

    def send_package(recipient_id)
        if recipient_id == ""
            return -1
        end
        @recipient = recipient_id
        @status_code = 2
        return 1
    end

    def receive_package(recipient_id)
        puts "recipient_id #{@recipient}"
        if recipient_id != @recipient
            return -1
        end
        @status_code = 3
        return 1
    end

end