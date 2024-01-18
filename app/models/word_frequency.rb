class WordFrequency < ApplicationRecord
  belongs_to :lesson

  validates :word, presence: true
  validates :tf_idf, presence: true
end
