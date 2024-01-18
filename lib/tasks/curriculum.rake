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

      stop_words = Set.new(%w[
                             a an and are as at be by for from has he in is it its of on that the to was were with there then how
                             i you your they them their we our us ours me my mine
                             this these those here there where when who what which
                             about above after again against all am an and any are aren't as at be because been before being below between both but by can't
                             cannot could couldn't did didn't do does doesn't doing don't down during each few for from further had hadn't has hasn't
                             have haven't having he he'd he'll he's her here here's hers herself him himself his how how's i i'd i'll i'm i've if
                             in into is isn't it it's its itself let's me more most mustn't my myself no nor not of off on once only or other ought
                             our ours ourselves out over own same shan't she she'd she'll she's should shouldn't so some such than that that's the
                             their theirs them themselves then there there's these they they'd they'll they're they've this those through to too under
                             until up very was wasn't we we'd we'll we're we've were weren't what what's when when's where where's which while who
                             who's whom why why's with won't would wouldn't you you'd you'll you're you've your yours yourself yourselves
                           ])
      total_word_count = Hash.new(0)
      lesson_word_count = {}
      word_frequencies = []

      Lesson.find_each do |lesson|
        tokens = tokenize(lesson, total_word_count, stop_words)
        lesson_word_count[lesson.id] = tokens
      end

      progressbar = ProgressBar.create total: Lesson.count, format: '%t: |%w%i| Completed: %c %a %e'
      Lesson.find_each do |lesson|
        progressbar.increment
        word_count = lesson_word_count[lesson.id]
        word_count.each do |word, tf|
          tf_idf = (tf.to_f / word_count.length.to_f) * (total_word_count[word].to_f / Lesson.count.to_f)
          word_frequencies << { lesson_id: lesson.id, word:, tf_idf: }
        end
      end

      WordFrequency.insert_all(word_frequencies)
    end
  end
end

def tokenize(lesson, total_word_count, stop_words)
  doc = Nokogiri::HTML5.parse(lesson.body)
  doc.css('code').remove
  text = ((lesson.title + ' ') * 5) + doc.text
  word_count = Hash.new(0)
  words = text.scan(/\b\w+\b/)

  words.each do |word|
    word = word.downcase
    next if stop_words.include? word

    word_count[word] += 1
    if word_count[word] == 1
      total_word_count[word] += 1
    end
  end

  word_count
end
