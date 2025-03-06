require_relative './ItemPackage.rb'
require 'securerandom'
require 'json'

class PackageFactory
    attr_accessor :factory_name
    # attr_accessor :orders
    # attr_accessor :package_storage
    def initialize(factory_name)
        @factory_name = factory_name
        @orders = {}
    end

    def create_item_package(name,contents,recipient_id)
        problems = []
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
            return {
                "package" => None,
                "problems" => problems
            }
        end

        new_package = ItemPackage.new(name,contents,recipient_id)
        @orders[new_package.get_package_id] = new_package

        return {
            "package" => new_package,
            "problems" => problems
        }
    end

    def send_package_order(package_id,recipient_id)
        if !@orders.key?(package_id)
            return -1
        end

        current_package = @orders[package_id]
        if current_package.get_recipient != recipient_id
            return -1
        end

        current_package.send_package(recipient_id)
        return 1
    end

    def track_package_order(package_id)
        if !@orders.key?(package_id)
            return {}
        end

        current_package = @orders[package_id]
        return current_package.check_status
    end
end

