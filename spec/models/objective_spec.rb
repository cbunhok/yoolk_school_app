require 'spec_helper'

  describe Objective do 

    it 'Objectives must be valid' do
        FactoryGirl.build(:objective, title: '').should_not be_valid
    end

    context 'Relationship: Objective belong to Course' do
      it { should belong_to(:course) }
    end
    # it 'Objectives parameter\'s name are corrected'  do
    #   objective = Objective.new(course_id: 1,
    #               description: 'Some description',
    #               title: 'something title of Objectives'
    #               )

    #   objective.description.should == 'Some description'
    #   objective.course_id.should == 1
    #   objective.title.should == "something title of Objectives"
    # end  
  end