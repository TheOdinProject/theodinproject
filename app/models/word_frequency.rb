class WordFrequency < ApplicationRecord
  belongs_to :lesson
  has_one :word
  has_one :fq
  has_one :tf

  validates :word, presence: true

  def index_lessons
    // TODO
  end
end
