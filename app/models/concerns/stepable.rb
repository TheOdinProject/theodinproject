module Stepable
  extend ActiveSupport::Concern

  included do
    has_many :steps, as: :learnable, dependent: :destroy
    has_many :children, lambda {
                          ordered
                        }, through: :steps, class_name: 'Step', foreign_key: :parent_id, dependent: :destroy
    has_many :parents, through: :steps, source: :parent, dependent: :destroy
  end
end
