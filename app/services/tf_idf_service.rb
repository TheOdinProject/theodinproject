class TfIdfService
  def initialize
    @df_table = Hash.new(0)
    @total_documents = 0
  end

  def populate_table(lesson_id, record)
    @total_documents += 1
    tf_table = tokenize(record)
    @tf_list << [lesson_id, tf_table]
  end

  def tokenize(_record)
    tf_table = Hash.new(0)
    words = text.scan(/\b\w+\b/)
    words.each do |word|
      word = word.downcase
      tf_table[word] += 1
      @df_table[word] += 1 if tf_map[word] == 1
    end
    tf_table
  end

  def list
    @tf_table.map do |lesson_id, tf_table|
      tf_idf = tf_table.map do |word, tf|
        score = calculate_tf_idf(tf, tf_table.length)
        [word, score]
      end

      [lesson_id, tf_idf]
    end
  end

  def calculate_tf_idf(term_f, document_size)
    df = @df_table[word]
    ((term_f.to_f / document_size) * Math.log((1 + @total_documents.to_f) / (1 + df)))
  end
end
