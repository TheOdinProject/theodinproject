class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.ransackable_attributes(_ = nil)
    authorizable_ransackable_attributes
  end

  def self.ransackable_associations(_ = nil)
    authorizable_ransackable_associations
  end
end
