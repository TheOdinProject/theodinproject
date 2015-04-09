class SectionCompletion < ActiveRecord::Base
  # This is the join table allowing students to see a which section of course is completed
  
  attr_accessible :student_id, :section_id, :created_at
  
  validates_presence_of [:student_id, :section_id]
  validates_uniqueness_of :student_id, :scope => :section_id
  
  belongs_to :student, :class_name => "User"
  belongs_to :section
end
