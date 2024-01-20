require 'nokogiri'
require 'net/http'
require 'uri'

class SearchIndexer
  def initialize(tf_idf_service)
    @tf_idf = tf_idf_service
    @external_links = {}
  end

  def index_frequencies
    Lesson.find_each do |lesson|
      record = parse_lesson(lesson)
      @tf_idf.populate_table(record[:url], record[:title], record[:text])
    end

    populate_database
  end

  def populate_database
    tf_idf_list = @tf_idf.tf_idf_list
    progressbar = ProgressBar.create total: tf_idf_list.length, format: '%t: |%w%i| Completed: %c %a %e'
    tf_idf_list.each do |list|
      search_record = SearchRecord.find_or_create_by(url: list[:url], title: list[:title])
      bulk_records = list[:tf_idf].map do |word, score|
        { search_record_id: search_record.id, word:, tf_idf: score }
      end
      TfIdf.upsert_all(bulk_records, unique_by: %i[search_record_id word])
      progressbar.increment
    end
  end

  def parse_lesson(lesson)
    doc = Nokogiri::HTML5.parse(lesson.body)
    doc.css('a[href]').each do |link|
      href = link[:href]
      next unless href.start_with?('http')

      @external_links[url: href] = link.text
    end

    { url: "https://www.theodinproject.com/lessons/#{lesson.slug}", title: lesson.title, text: doc.text }
  end

  def parse_external_links
    progressbar = ProgressBar.create total: @external_links.length, format: '%t: |%w%i| Completed: %c %a %e'
    @external_links.each do |url, title|
      uri = URI.parse(url)
      response = Net::HTTP.get_response(uri)
      next unless response.is_a?(Net::HTTPSuccess)

      @tf_idf.populate_table(url, title, Nokogiri::HTML5.parse(response.body).text)
      progressbar.increment
    rescue StandardError => _e
      puts "Error: #{url}"
    end
  end
end
