require 'csv'
require_relative './web_scrapers/web_scraper_project.rb'

# puts results

def try_lazada_scraping
    scraper_test = WebScraper.new
    scraper_test.select_platform("lazada")
    scraper_test.query_words = "cinnamoroll"
    scraper_test.set_page_limit(15)
    results = scraper_test.scrape_platform
    CSV.open(
        'lazada_listings.csv',
        'w+',
        write_headers: true,
        headers: %w[Name Price Country Image]
      ) do |csv|
        results.each do |result|
            csv << [result["item_name"], result["item_price"], result["item_country"],result["image_source"]]
        end
    end    
end


try_lazada_scraping