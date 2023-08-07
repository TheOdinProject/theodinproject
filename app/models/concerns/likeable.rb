module Likeable
  extend ActiveSupport::Concern

  included do
    has_many :likes, as: :likeable, dependent: :destroy
    attribute :liked, :boolean, default: false
  end

  def liked_by?(user)
    likes.exists?(user:)
  end

  def like(user)
    likes.find_or_create_by(user:)

    liked!
  end

  def unlike(user)
    likes.destroy_by(user:)

    unliked!
  end

  def liked!
    self.liked = true
  end

  def unliked!
    self.liked = false
  end
end
