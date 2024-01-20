class TfIdf < ApplicationRecord
  belongs_to :search_record

  validates :word, presence: true
  validates :score, presence: true
end
