class Content < ApplicationRecord
  belongs_to :lesson

  validates :body, presence: true
end
