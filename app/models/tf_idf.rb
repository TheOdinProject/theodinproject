class TfIdf < ApplicationRecord
  belongs_to :lesson

  validates :word, presence: true
  validates :score, presence: true
end
