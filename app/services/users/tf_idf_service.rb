class TfIdfService
  def initialize
    @df_table = {}
    @tf_table = {}
    @total_documents = 0
    @tf_idf_list = []
  end

  def populate_table(key, text, title)
    @total_documents += 1
    tokenize(key, text + title)
  end

  def tokenize(key, text)
    word_count = Hash.new(0)
    words = text.scan(/\b\w+\b/)
    words.each do |word|
      word = word.downcase
      word_count[word] += 1
      if word_count[word] == 1
        @df_table[word] += 1
      end
    end

    @tf_table << { key:, word_count: }
  end

  def generate_tf_idf_list
    @tf_table.each do |_key, tf_map|
      tf_map.each do |word, _tf|
        tf_idf = calculate_tf_idf(key, word)
        tf_idf_list << { lesson_id:, word:, tf_idf: }
      end
    end
  end

  def calculate_tf_idf(key, word)
    tf_table = @tf_table[key]

    total_tf = tf_table.length
    tf = tf_table[word]
    df = @df_table[word]
    (tf.to_f / total_tf) * Math.log((1 + @total_documents.to_f) / (1 + df))
  end
end
