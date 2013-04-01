require 'spec_helper'

describe Category do
  describe 'Step 1: testing with relationship' do
		context 'Testing with relationship' do
			it 'Category should have Courses' do
				course = Course.new()
				category = Category.new(courses: [course])

				category.courses.should include(course)
			end
		end		
	end

	describe 'Gategory structure' do

		
		# it 'testing attributes valid or not' do
		# 	category = Category.new(title: 'title',description: 'description')

		# 	category.title.should == 'title'
		# 	category.description.should == 'description'
		# end

		it 'title must be valid' do
			category = Category.new()
			category.should_not be_valid
		end

		# it 'Gategory should have many courses' do

		# 	course1 = Course.new(title: 'Ruby')
		# 	course2 = Course.new(title: 'c++')
		# 	category = Category.new(title: 'Courses', courses: [course1, course2])
		# 	category.courses.should include(course1)
		# 	category.courses.should include(course2)

		# end
		context 'Relationship: CATEGORY have many COURSES'  do
			it { should have_many(:courses) }
		end

		context 'Relationship : CATEGORY have many COURSES with dependent destroy' do
			it { should have_many(:courses).dependent(:destroy) }
		end

	end

end
