require "nokogiri"
require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = File.read(index_url)
    page = Nokogiri::HTML(html)
    # binding.pry
    array = []
    page.css(".roster-cards-container .student-card").each do |a|
      hash = {}
      name = a.css(".card-text-container .student-name").text
      location = a.css(".card-text-container .student-location").text
      url = a.css("a").attribute("href").value
      hash[:name] = name
      hash[:location] = location
      hash[:url] = url
      array << hash
    end
    array
    # name - page.css(".roster-cards-container .student-card .card-text-container .student-name").each do |name|
    # puts name.text
    # end
    # location - page.css(".roster-cards-container .student-card .card-text-container .student-location").each do |location|
    # puts location.text
    # end
    # url - page.css(".roster-cards-container .student-card").each do |a|
    #   puts a.css("a").attribute("href").value
    # end
  end

  def self.scrape_profile_page(profile_url)
    # html = File.read(profile_url)
    # Nokogiri::HTML(html)
  end

end
