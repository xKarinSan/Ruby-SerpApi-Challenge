require_relative './classes/ItemPackage.rb'
require_relative './classes/PackageFactory.rb'
require_relative './classes/Logs.rb'

puts "Welcome to day 2!"

class Package
    attr_accessor :name
    attr_accessor :contents
    attr_accessor :status_code
    def initialize(name, contents)
        @name = name
        @contents = contents
        @status_code = 1
        puts "#{name} is created!"
    end

    def check_status
        status_message = ""
        if @status_code == 1
            status_message = "Package is new!"

        else
            status_message =  "This package is tampered with, please fix it!"
        end
        return {
            "status_code" => @status_code,
            "message" => status_message
        }

    end
end

def first_function_call
    puts "First function call is here! \n\n"
    package_a = Package.new("Package","NA")
    package_a_contents = package_a.contents
    puts "Package A's Contents: #{package_a_contents}"

    package_a_status = package_a.check_status
    puts package_a_status

    puts "Package A is being tampered with..."
    package_a.status_code = 3
    package_a_new_status = package_a.check_status
    puts package_a_new_status
end

def factory_and_packages
    logger = Logger.new()
    test_factory = PackageFactory.new("Milk Factory",logger)

    customer_1 = "abc123"
    thief_1 = "abcl23"

    created_package_task = test_factory.create_item_package("Milk Delivery","Chocolate_milk",customer_1)
    created_package = created_package_task[:package]
    # puts created_package
    # puts created_package.check_status

    send_package_task = test_factory.send_package_order(created_package.get_package_id, customer_1)
    # puts send_package_task

    track_package_task = test_factory.track_package_order(created_package.get_package_id)
    # puts track_package_task

    steal_attempt = created_package.receive_package(thief_1)
    # puts steal_attempt

    receive_attempt = created_package.receive_package(customer_1)
    # puts receive_attempt

    logger.display_all_logs

end



# first_function_call
factory_and_packages