require 'nokogiri'

namespace :curriculum do
  desc 'Grab Latest Lesson Content from Github'
  task update_content: :environment do
    Rake::Task['curriculum:content:import'].invoke
    Rake::Task['curriculum:content:verify'].invoke
    # Rake::Task['curriculum:content:index'].invoke
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
      Rails.logger.info 'Indexing content...'

      Lesson.find_each do |lesson|
        tokens = tokenize(((lesson.title + ' ') * 5) + lesson.body)
        tokens.each do |word, count|
          puts word, count

          # lesson.word_frequencies.create(word: 'test', tf: 0.75, idf: 1.25)
        end
      end
    end
  end
end

def tokenize(html_content)
  text = Nokogiri::HTML(html_content).text
  word_count = Hash.new(0)
  words = text.scan(/\b\w+\b/)

  words.each do |word|
    word_count[word.downcase] += 1
  end

  total_words_count = word_count.length.to_f
  word_count.map do |word, count|
    tf = count / total_words_count

    [word, count]
  end
end
