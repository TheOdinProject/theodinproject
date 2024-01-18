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

    task index: :environment do
      Rails.logger.info 'Indexing content for searching...'
      progressbar = ProgressBar.create total: Lesson.count, format: '%t: |%w%i| Completed: %c %a %e'

      total_word_count = Hash.new(0)
      lesson_word_count = {}
      Lesson.find_each do |lesson|
        tokens = tokenize lesson
        lesson_word_count[lesson.id] = tokens

        tokens.each do |word, _|
          total_word_count[word.downcase] += 1
        end
      end

      total_lessons = Lesson.count
      Lesson.find_each do |lesson|
        progressbar.increment
        word_count = lesson_word_count[lesson.id]
        word_count.each do |word, tf|
          total_words = lesson
          tf_idf = (tf.to_f / word_count.length.to_f) * (total_word_count[word].to_f / total_lessons.to_f)
          lesson.word_frequencies.create(word:, tf_idf:)
        end
      end
    end
  end
end

def tokenize(lesson)
  doc = Nokogiri::HTML(lesson.title)
  # doc.xpath('code').each { |node| node.remove }
  text = doc.text
  word_count = Hash.new(0)
  words = text.scan(/\b\w+\b/)

  words.each do |word|
    word_count[word.downcase] += 1
  end

  word_count
end
