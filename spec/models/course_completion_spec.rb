require 'spec_helper'

describe CourseCompletion do
      let!(:user){ FactoryGirl.create(:user) }
  let!(:course){ FactoryGirl.create(:course) }
  
  subject(:course_completion) { CourseCompletion.new(   
    :student_id => user.id,
    :course_id => course.id
                               )}

  it { should respond_to(:student) }
  it { should respond_to(:course) }
  it { should be_valid }

  context "when course and student are duplicated" do
    before do
      CourseCompletion.create(:student_id => user.id, :course_id => course.id)
    end
    it { should_not be_valid }
  end
end
