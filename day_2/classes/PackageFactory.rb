require_relative './ItemPackage.rb'
require_relative './Logs.rb'
require 'securerandom'
require 'json'

class PackageFactory
    attr_accessor :factory_name
    # attr_accessor :orders
    # attr_accessor :package_storage
    def initialize(factory_name,logger)
        @factory_name = factory_name
        @orders = {}
        @logger = logger
    end

    def create_item_package(name,contents,recipient_id)
        problems = []
        res = {}
        if name == ""
            problems.append("Package name cannot be empty")
        end
        if contents == ""
            problems.append("Package contents cannot be empty")
        end

        if recipient_id == ""
            problems.append("Recipient ID cannot be empty")
        end

        if problems.length() > 0
            puts "[PackageFactory][create_item_package] Failed to create package."
            res = {
                "package" => None,
                "problems" => problems
            }
            @logger.add_log(res,"POST")
            return res
        end

        new_package = ItemPackage.new(name,contents,recipient_id,@logger)
        @orders[new_package.get_package_id] = new_package

        puts "[PackageFactory][create_item_package] Successfully created package."
        res = {
            "package" => new_package,
            "problems" => problems
        }
        @logger.add_log(res,"POST")
        return res
    end

    def send_package_order(package_id,recipient_id)
        if !@orders.key?(package_id)
            puts "[PackageFactory][send_package_order] Package not found."
            @logger.add_log({"package_id"=>package_id,"recipient_id"=>recipient_id,"status"=>-1},"POST")
            return -1
        end

        current_package = @orders[package_id]
        if current_package.get_recipient != recipient_id
            puts "[PackageFactory][send_package_order] Wrong recipient of package."
            @logger.add_log({"package_id"=>package_id,"recipient_id"=>recipient_id,"status"=>-1},"POST")
            return -1
        end

        current_package.send_package(recipient_id)
        puts "[PackageFactory][send_package_order] Package successfully sent."
        @logger.add_log({"package_id"=>package_id,"recipient_id"=>recipient_id,"status"=>1},"POST")
        return 1
    end

    def track_package_order(package_id)
        if !@orders.key?(package_id)
            puts "[PackageFactory][track_package_order] Package not found."
            @logger.add_log({"package_id"=>package_id,"package_status"=>{}},"GET")
            return {}
        end

        current_package = @orders[package_id]
        package_status = current_package.check_status
        puts "[PackageFactory][track_package_order] Package exists,sending status"
        @logger.add_log({"package_id"=>package_id,"package_status"=>package_status},"GET")
        return package_status
    end
end

