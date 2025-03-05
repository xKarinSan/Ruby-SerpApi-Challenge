require 'json'

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

first_function_call