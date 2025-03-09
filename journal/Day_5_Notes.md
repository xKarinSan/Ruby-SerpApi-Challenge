## 8/3/25 Entry
After reading up on web scraping as part of SerpApi's domain, I have decided to build a web-scraper for e-commerce in order to help users make informed decisions.

As I do not have much experience in web scraping, but roughly have an idea on how to do it, I watched this <a href="https://www.youtube.com/watch?v=GnVZexqtosc">video</a> to learn the ruby implementation of a simple web scraper. 

In ruby implementation, the following gems (or packages) are needed:
- HTTParty: streamlines the process of making HTTP requests in Ruby
- Nokogiri: parses and manipulate XML and HTML, which allows ease of navigation in the extracted HTML tree
- CSV: this is to save the scraped data as ```.csv``` files
- Selenium WebDriver: This is to carry out web scraping for dynamic web pages


Based on that video, the rough flow is usually:
- for loop (if you know the number of pages), for the case of paginations
- use a write operation for CSV: to write the scraped data in this file
- loop through through each page and narrow down to the relevant HTML elements of the data to be picked out
- format the data of each row such that it is ready

The folow is similar for scraping dynamic pages, except that selenium is being used to simulate users finding the specific tags, as well as actions to click on buttons.

I have attempted to create an ecommerce web scraper. There were challenges that I faced and overcame
- Familarising myself with selenium
- Inspecting the elements for the web page to extract out ceertain information
- Syntax-related (as I am fairly new to Ruby), I am confident that I can be familar with Ruby in due time =)

***TL;DR: Decided to build an e-commerce web scraper using Ruby, learning about HTTParty, Nokogiri, CSV, and Selenium WebDriver; overcame challenges in Selenium usage, HTML element inspection, and Ruby syntax, gaining confidence in the language. 🚀***