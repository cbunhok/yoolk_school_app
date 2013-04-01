require 'spec_helper'

  describe Course do
    describe 'Objective structure' do
      it 'testing attributes should be valid can crrect parameter\' names' do
        course = Course.new(title: 'title',
                            category_id: 1, 
                            cost_per_day: 200,
                            duration: 10,
                            is_published: true,
                            short_title:'short_title', 
                            summary:'summary')


        course.title.should == 'title'
        course.category_id.should == 1
        course.cost_per_day.should == 200
        course.duration.should == 10
        course.is_published.should == true
        course.short_title.should == 'short_title'
        course.summary.should == 'summary'
      end
    end

      it 'title must be valid' do
        course = Course.new()
        course.should_not be_valid
      end

      it 'Course should have many Objective in relationship' do

        object1 = Objective.new(title: 'Introduction of Ruby')
        object2 = Objective.new(title: 'Ruby OOP')
        course = Course.new(title: 'Ruby BOok', objectives: [object1, object2])
        course.objectives.should include(object1)
        course.objectives.should include(object2)

      end
  end
