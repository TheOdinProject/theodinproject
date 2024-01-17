class WordFrequency < ApplicationRecord
  belongs_to :lesson

  validates :word, presence: true
  validates :tf, presence: true
  validates :idf, presence: true
end
