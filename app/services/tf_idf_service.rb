class TfIdfService
  def initialize
    @df_table = {}
    @tf_table = {}
    @total_documents = 0
  end

  def populate_table(key, text, title)
    @total_documents += 1
    tokenize(key, title, text)
  end

  def tokenize(key, title, text)
    word_count = Hash.new(0)
    words = text.scan(/\b\w+\b/)
    words.each do |word|
      word = word.downcase
      word_count[word] += 1
      if word_count[word] == 1
        @df_table[word] += 1
      end
    end

    @tf_table << { key:, title:, word_count: }
  end

  def tf_idf_list
    tf_idf_list = []
    @tf_table.each do |key, tf_map|
      tf_idf = []
      tf_map.each_key do |word|
        tf_idf_score = calculate_tf_idf_score(key, word)
        tf_idf << [word:, tf_idf_score:]
      end

      @tf_idf_list << { key:, tf_idf: }
    end
    tf_idf_list
  end

  def calculate_tf_idf_score(key, word)
    tf_table = @tf_table[key]

    total_tf = tf_table.length
    tf = tf_table[word]
    df = @df_table[word]
    (tf.to_f / total_tf) * Math.log((1 + @total_documents.to_f) / (1 + df))
  end
end
