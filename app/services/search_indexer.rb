require 'nokogiri'

class SearchIndexer
  def self.index_frequencies
    # Lesson.find_each do |lesson|
    #   text = extract_lesson_document(lesson)
    #   tokens = tokenize(text, total_word_count)
    #   lessons_word_count[lesson.id] = tokens
    # end

    tf_idf = TfIdfService.new

    title = 'this is a title'
    text = "this is a very long text supposedly so let's see if it actually works"
    url = 'key.com'
    tf_idf.populate_table(url, title, text)

    tf_idf.tf_idf_list.each do |list|
      puts list.inspect
    end
  end
end
