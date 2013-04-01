require 'spec_helper'

  describe Course do
      it 'validation on course must be valid' do
        FactoryGirl.build(:course, 
          title: 'ruby', duration: 7, cost_per_day: 9).should be_valid
      end

      # it 'Course should have many Objective in relationship' do

      #   object1 = Objective.new(title: 'Introduction of Ruby')
      #   object2 = Objective.new(title: 'Ruby OOP')
      #   course = Course.new(title: 'Ruby BOok', objectives: [object1, object2])
      #   course.objectives.should include(object1)
      #   course.objectives.should include(object2)

      # end
      context 'Relationship: COURSE have many OBJECTIIVE' do
        it { should have_many(:objectives) }
      end

      context 'Relationship: Course belong to Category' do
        it {should belong_to(:category)}
      end

      context 'Relationship: COURSE have many OBJECTIIVE dependent destroy' do
        it { should have_many(:objectives).dependent(:destroy) }
      end
  end
