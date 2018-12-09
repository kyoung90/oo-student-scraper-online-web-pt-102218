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
      hash[:profile_url] = url
      array << hash
    end
    array
  end

  def self.scrape_profile_page(profile_url)
     html = File.read(profile_url)
     page = Nokogiri::HTML(html)

     hash = {}

     page.css(".main-wrapper.profile").each do |some_html|
       some_html.css(".social-icon-container a").each do |a|
          social_media_link = a.attribute("href").value
          if social_media_link.include?("twitter")
            hash[:twitter] = social_media_link
          elsif social_media_link.include?("github")
            hash[:github] = social_media_link
          elsif social_media_link.include?("linkedin")
            hash[:linkedin] = social_media_link
          elsif social_media_link
            hash[:blog] = social_media_link
          end
        end
       hash[:profile_quote] = some_html.css(".profile-quote").text
       hash[:bio] = some_html.css(".description-holder p").text
     end

     hash
  end

end
