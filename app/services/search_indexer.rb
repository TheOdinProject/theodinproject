require 'nokogiri'

class SearchIndexer
  def initialize(tf_idf_service)
    @tf_idf = tf_idf_service
    @external_links = {}
  end

  def index_frequencies
    Lesson.find_each do |lesson|
      record = parse_lesson(lesson)
      @tf_idf.populate_table(lesson.id, record)
    end

    populate_database
  end

  def populate_database
    list = @tf_idf.list
    progressbar = ProgressBar.create total: list.length, format: '%t: |%w%i| Completed: %c %a %e'
    list.each do |lesson_id, tf_idf|
      bulk_records = tf_idf.map do |word, score|
        { lesson_id:, word:, score: }
      end
      TfIdf.upsert_all(bulk_records, unique_by: %i[lesson_id word])
      progressbar.increment
    end
  end

  def parse_lesson(lesson)
    text = Nokogiri::HTML5.parse(lesson.body).text
    { title: lesson.title, desc: lesson.description, text: }
  end
end
