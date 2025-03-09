require 'selenium-webdriver'
require 'csv'

def scrape_dynamic_pages
    quotes = []
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')

    driver = Selenium::WebDriver.for(:chrome, options: options)
    
    driver.get 'http://quotes.toscrape.com/js/' # Corrected URL
    
    while true do
        quote_elements = driver.find_elements(:css, '.quote')
        quote_elements.each do |quote_el|
            quote_text = quote_el.find_element(:css, '.text').attribute('textContent')
            author = quote_el.find_element(:css, '.author').attribute('textContent')
            quotes << [quote_text, author]
        end
        
        begin
            driver.find_element(:css, '.next > a').click
        rescue Selenium::WebDriver::Error::NoSuchElementError
            # No more next button
            break
        end
    end

    CSV.open(
        'quotes.csv',
        'w+',
        write_headers: true,
        headers: ['Quote', 'Author']
    ) do |csv|
        quotes.each do |quote|
            csv << quote
        end
    end

    driver.quit # Close the browser after scraping
end

scrape_dynamic_pages
