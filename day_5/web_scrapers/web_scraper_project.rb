require 'selenium-webdriver'

class WebScraper
    attr_accessor :query_words
    # attr_accessor: :current_page_no
    def initialize
        @current_platform_name = ""

        @platform_names = {
            "amazon" => "https://amazon.sg/s?k=",
            "lazada" => "https://www.lazada.sg/tag/"
        }
        @query_words = ""
        @page_limit = 5
    end
    def set_page_limit(new_page_limit)
        if new_page_limit < 1
            @page_limit = 1
            return
        end
        @page_limit = new_page_limit
    end


    def select_platform(platform_name)
        # check if platform name is empty or inside
        puts platform_name

        if platform_name.empty? || !@platform_names.key?(platform_name)
            puts "Key is not found!"
            return
        end

        @current_platform_name = platform_name

    end

    def start_driver
        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        driver = Selenium::WebDriver.for(:chrome, options: options)
        return driver
    end

    def scrape_lazada
        driver = self.start_driver
        lazada_listings = []
        counter = 0
        lazada_query = @query_words.split(/ /).join("-")

        while counter < @page_limit
            search_url = "#{@platform_names['lazada']}#{lazada_query}?page=#{counter+1}"
            puts "#{counter+1}/#{@page_limit}"
            driver.get search_url

            product_containers = driver.find_elements(:css, '.Bm3ON')
            # puts product_containers
            product_containers.each do |product|
                item_name = product.find_element(:css, '.RfADt').text rescue "N/A"
                item_price = product.find_element(:css, '.ooOxS').text rescue "N/A"
                item_country = product.find_element(:css, '.oa6ri').text rescue "N/A"
                image_source = product.find_element(:tag_name, 'img').attribute('src') rescue "N/A"
                lazada_listings <<  {item_name: item_name, item_price: item_price, item_country: item_country, image_source: image_source}
            end
            counter += 1        
        end
        return lazada_listings
      end


    def scrape_amazon
        driver = self.start_driver
        amazon_listings = []
        counter = 0
        amazon_query = @query_words.split(/ /).join("+")

        while counter < @page_limit
            search_url = "#{@platform_names['amazon']}#{amazon_query}&page=#{counter+1}"
            puts "#{counter+1}/#{@page_limit}"
            driver.get search_url

            product_containers = driver.find_elements(:css,'div.s-card-container')
            # puts product_containers
            product_containers.each do |product|
                item_name = product.find_element(:css, "h2.a-size-base-plus.a-spacing-none.a-color-base.a-text-normal").text                
                whole_num_price = product.find_element(:css, '.a-price-whole').text rescue "0"
                decimal_price = product.find_element(:css, '.a-price-fraction').text rescue "00"
                item_price = "#{whole_num_price}.#{decimal_price}"
                image_source = product.find_element(:tag_name, 'img').attribute('src') rescue "N/A"
                amazon_listings <<  {item_name: item_name, item_price: item_price, image_source: image_source}
            end
            counter += 1
        end
        return amazon_listings
    end

    def scrape_platform
        scraped_items = []
        puts "Scraping ..."
        if  @platform_names.has_key?(@current_platform_name) == false
            puts "Invalid key"
            return scraped_items
        end
        if @query_words == ""
            puts "Search text cannot be empty"
            return scraped_items
        end

        case @current_platform_name

        when "amazon"
            scraped_items = self.scrape_amazon
        when "lazada"
            scraped_items = self.scrape_lazada

        return scraped_items
    end

end
end