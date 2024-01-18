require 'nokogiri'

namespace :curriculum do
  desc 'Grab Latest Lesson Content from Github'
  task update_content: :environment do
    # Rake::Task['curriculum:content:import'].invoke
    # Rake::Task['curriculum:content:verify'].invoke
    Rake::Task['curriculum:content:index'].invoke
  end

  namespace :content do
    desc 'Import all lessons content from GitHub'
    task import: :environment do
      progressbar = ProgressBar.create total: Lesson.count, format: '%t: |%w%i| Completed: %c %a %e'

      Lesson.find_each do |lesson|
        lesson.import_content_from_github
        progressbar.increment
      end
    end

    desc 'Verify that all lessons have content'
    task verify: :environment do
      Rails.logger.info 'Verifying lesson content...'

      Lesson.find_each do |lesson|
        Rails.logger.error("Nil content for #{lesson.title}!") if lesson.content.nil?
        Rails.logger.error("Blank content for #{lesson.title}!") if lesson.content.blank?
      end

      Rails.logger.info 'Lesson content verified.'
    end

    desc 'Index documents for searching'
    task index: :environment do
      Rails.logger.info 'Indexing content for searching...'

      total_word_count = Hash.new(0)
      lesson_word_count = {}

      Lesson.find_each do |lesson|
        tokens = tokenize(lesson, total_word_count)
        lesson_word_count[lesson.id] = tokens
      end

      word_frequencies = []
      progressbar = ProgressBar.create total: Lesson.count, format: '%t: |%w%i| Completed: %c %a %e'
      lesson_word_count.each do |lesson_id, word_count|
        progressbar.increment
        word_count.each do |word, tf|
          tf_idf = (tf.to_f / word_count.length.to_f) * Math.log((1 + Lesson.count.to_f) / (1 + total_word_count[word].to_f))
          word_frequencies << { lesson_id:, word:, tf_idf: }
        end
      end

      WordFrequency.insert_all(word_frequencies)
    end
  end
end

def tokenize(lesson, total_word_count)
  # doc = Nokogiri::HTML5.parse(lesson.body)
  # doc.css('code').remove
  # text = ((lesson.title + ' ') * 5) + doc.text
  text = lesson.title
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
