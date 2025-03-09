require 'httparty'
require 'nokogiri'
require 'csv'
def scrape_static_pages()
    # books = []
    CSV.open(
        'books.csv',
        'w+',
        write_headers: true,
        headers: %w[Title, Price, Categories]
      ) do |csv|
    10.times do |i|
        res = HTTParty.get("https://books.toscrape.com/catalogue/page-#{i+1}.html")
        if res.code == 200
            puts "Page #{i+1}/10 OK"
        else
            puts "Error: #{res.code}"
        end

        document = Nokogiri::HTML4(res.body)
        # the main container
        book_containers = document.css('article.product_pod')
        book_containers.each do |container|
            # each HTML element with the relevant information
            title = container.css('h3 a').first['title']
            price = container.css('.price_color').text.delete('^0-9')
            availability = container.css('.availability').text.strip

            ## this to visualise what each row could look like in JSON
            # book = {
            #     "title" => title,
            #     "price" => price,
            #     "availability" => availability
            # }
            book = [title, price, availability]
            # books.append(book)
            csv << book
            # this can be in a database for real cases, or the csv files can be sent to file storages like Amazon S3
        end
    end
end
end
# handle pagination: add the page number in the link


scrape_static_pages