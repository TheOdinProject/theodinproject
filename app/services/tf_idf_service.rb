class TfIdfService
  def initialize
    @df_table = Hash.new(0)
    @tf_list = []
    @total_documents = 0
  end

  def populate_table(lesson_id, record)
    @total_documents += 1
    tf_table = tokenize(record)
    @tf_list << [lesson_id, tf_table]
  end

  def tokenize(record)
    tf_table = Hash.new(0)
    title = "#{record[:title]} " * 10
    desc = "#{record[:desc]} " * 2
    words = "#{title} #{desc} #{record[:text]}".scan(/\b[a-zA-Z']+\b/)
    words.each do |word|
      word = word.downcase
      tf_table[word] += 1
      @df_table[word] += 1 if tf_table[word] == 1
    end
    tf_table
  end

  def list
    @tf_list.map do |lesson_id, tf_table|
      tf_idf = tf_table.map do |word, tf|
        score = calculate_tf_idf(tf, tf_table.length, word)
        [word, score]
      end

      [lesson_id, tf_idf]
    end
  end

  def calculate_tf_idf(term_f, document_size, word)
    df = @df_table[word]
    ((term_f.to_f / document_size) * Math.log((1 + @total_documents.to_f) / (1 + df)))
  end
end
