class TfIdfService
  def initialize
    @df_table = Hash.new(0)
    @tf_table = {}
    @total_documents = 0
  end

  def populate_table(key, title, text)
    @total_documents += 1
    tokenize(key, title, text)
  end

  def tokenize(key, title, text)
    tf_map = Hash.new(0)
    words = text.scan(/\b\w+\b/)
    words.each do |word|
      word = word.downcase
      tf_map[word] += 1
      if tf_map[word] == 1
        @df_table[word] += 1
      end
    end

    @tf_table[key] = { title:, tf_map: }
  end

  def tf_idf_list
    tf_idf_list = []
    @tf_table.each do |key, record|
      tf_idf = []
      record[:tf_map].each_key do |word|
        tf_idf_score = calculate_tf_idf_score(key, word)
        tf_idf << [word, tf_idf_score]
      end

      tf_idf_list << { key:, title: record[:title], tf_idf: }
    end
    tf_idf_list
  end

  def calculate_tf_idf_score(key, word)
    tf_table = @tf_table[key]

    total_tf = tf_table.length
    tf = tf_table[:tf_map][word]
    df = @df_table[word]
    (tf.to_f / total_tf) * Math.log((1 + @total_documents.to_f) / (1 + df))
  end
end
