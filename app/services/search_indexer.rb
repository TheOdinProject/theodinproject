require 'nokogiri'
require 'net/http'
require 'uri'

class SearchIndexer
  def initialize(tf_idf_service)
    @tf_idf = tf_idf_service
    @external_links = []
  end

  def index_frequencies
    Lesson.find_each do |lesson|
      record = parse_lesson(lesson)
      @tf_idf.populate_table("https://www.theodinproject.com/lessons/#{record[:url]}", record[:title], record[:text])
    end

    count = 0
    @tf_idf.tf_idf_list.each do |list|
      count += list[:tf_idf].length
    end

    puts count.length
  end

  def parse_lesson(lesson)
    doc = Nokogiri::HTML5.parse(lesson.body)
    doc.css('a[href]:not(.anchor-link)').each do |link|
      @external_links << [link[:href], link.text]
    end

    { url: "https://www.theodinproject.com/lessons/#{lesson.slug}", title: lesson.title, text: doc.text }
  end

  def parse_external_links
    @external_links.each do |url, title|
      uri = URI.parse(url)
      response = Net::HTTP.get_response(uri)
      text = Nokogiri::HTML5.parse(response.body).text
      @tf_idf.populate_table(url, title, text)
    end
  end
end
