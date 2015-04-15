class Section < ActiveRecord::Base
  attr_accessible :course_id, :position, :title, :title_url, :description

  belongs_to :course
  has_many :lessons
  
  has_many :section_completions, :dependent => :destroy
  has_many :completing_users, :through => :section_completions, :source => :student

  validates_uniqueness_of :position, :message => "Section position has already been taken"
  
  def section_percent_completed_by(user)
    uncompleted_lesson = self.lessons - user.completed_lessons
    100 * (1.0 - uncompleted_lesson .count.to_f / self.lessons.count.to_f)
  end
end
