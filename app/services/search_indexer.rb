require 'nokogiri'

class SearchIndexer
  @@external_links = []
  def self.index_frequencies
    tf_idf = TfIdfService.new
    Lesson.find_each do |lesson|
      record = parse_lesson(lesson)
      tf_idf.populate_table(record[:url], record[:title], record[:text])
    end

    count = 0
    tf_idf.tf_idf_list.each do |list|
      count += list[:tf_idf].length
    end
  end

  def self.parse_lesson(lesson)
    doc = Nokogiri::HTML5.parse(lesson.body)
    doc.css('a[href]:not(.anchor-link)').each do |link|
      @@external_links << [link[:href], link.text]
    end

    { url: "https://www.theodinproject.com/lessons/#{lesson.slug}", title: lesson.title, text: doc.text }
  end
end
