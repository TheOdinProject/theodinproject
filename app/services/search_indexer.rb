require 'nokogiri'

class SearchIndexer
  def self.index_frequencies
    total_word_count = Hash.new(0)
    lesson_word_count = {}

    Lesson.find_each do |lesson|
      text = extract_lesson_document(lesson)
      tokens = tokenize(text, total_word_count)
      lesson_word_count[lesson.id] = tokens
    end

    word_frequencies = []
    progressbar = ProgressBar.create total: Lesson.count, format: '%t: |%w%i| 2/2 Completed: %c %a %e'
    lesson_word_count.each do |lesson_id, word_count|
      word_count.each do |word, tf|
        tf_idf = (tf.to_f / word_count.length.to_f) * Math.log((1 + Lesson.count.to_f) / (1 + total_word_count[word].to_f))
        word_frequencies << { lesson_id:, word:, tf_idf: }
      end
      progressbar.increment
    end

    WordFrequency.insert_all(word_frequencies)
  end

  def self.tokenize(text, total_word_count)
    word_count = Hash.new(0)
    words = text.scan(/\b\w+\b/)
    words.each do |word|
      word = word.downcase
      word_count[word] += 1
      if word_count[word] == 1
        total_word_count[word] += 1
      end
    end

    word_count
  end

  def self.extract_lesson_document(lesson)
    # doc = Nokogiri::HTML5.parse(lesson.body)
    # doc.css('code').remove
    # text = ((lesson.title + ' ') * 5) + doc.text
    text = lesson.title
  end
end
