require 'spec_helper'

describe SectionCompletion do
    let!(:user){ FactoryGirl.create(:user) }
  let!(:section){ FactoryGirl.create(:section) }
  
  subject(:section_completion) { SectionCompletion.new(   
    :student_id => user.id,
    :section_id => section.id
                               )}

  it { should respond_to(:student) }
  it { should respond_to(:section) }
  it { should be_valid }

  context "when section and student are duplicated" do
    before do
      SectionCompletion.create(:student_id => user.id, :section_id => section.id)
    end
    it { should_not be_valid }
  end
  
end
