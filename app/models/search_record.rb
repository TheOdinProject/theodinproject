class SearchRecord < ApplicationRecord
  has_many :tf_idf, dependent: :destroy

  validates :title, presence: true
  validates :url, presence: true
end
