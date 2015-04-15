class CourseCompletion < ActiveRecord::Base
  # This is the join table allowing students to see a which course is completed
  
  attr_accessible :student_id, :course_id, :created_at
  validates_presence_of [:student_id, :course_id]
  validates_uniqueness_of :student_id, :scope => :course_id
  
  belongs_to :student, :class_name => "User"
  belongs_to :course
end
