require 'spec_helper'

describe HomeController do
  
	# describe 'Test home page' do
	# 	it 'show a list of all course in home/index' do
	# 		get :index
	# 		expect(response).to render_template(:index)
	# 	end 
	# end

  it 'List Category' do
    course = FactoryGirl.create(:course)
    category = FactoryGirl.create(:category, courses: [course])

    # get categories_path
    get :index
    expect(response).to render_template(:index)

    category.courses.should include(course)

    expect(response.body).to include('Ruby')
    expect(response.body).to include('Variable')
  end

end