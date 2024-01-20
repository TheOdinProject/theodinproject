require 'nokogiri'

class SearchIndexer
  def self.index_frequencies
    total_word_count = Hash.new(0)
    lessons_word_count = {}

    Lesson.find_each do |lesson|
      text = extract_lesson_document(lesson)
      tokens = tokenize(text, total_word_count)
      lessons_word_count[lesson.id] = tokens
    end

    tf_idf_listtract_word_frequencies(lessons_word_count, total_word_count, Lesson.count)
    WordFrequency.insert_all(tf_idf_list)
  end
end
