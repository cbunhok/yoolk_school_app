require 'spec_helper'

describe CategoriesController do

  it 'List Category' do
  	course = FactoryGirl.create(:course)
  	category = FactoryGirl.create(:category, courses: [course])

    get categories_path
    expect(response).to render_template('index')

    category.courses.should include(course)

    expect(response.body).to include('Ruby')
    expect(response.body).to include('Variable')
  end

  it 'show category/1' do
  	course = FactoryGirl.create(:course)
  	category = FactoryGirl.create(:category, courses: [course])

  	category.courses.should include(course)

    get category_path(category)
  	expect(response).to render_template('show')

  	expect(response.body).to include('Ruby')
  end

  context 'Go to new form' do

    before :each do
      get new_category_path
    end

    # it { should assign_to(:category).with_kind_of(Category) }
    it "should be new record" do
      assigns(:category).should be_new_record
    end
  	it { should render_template :new }
    # expect(response).to render_template('new')
  end

  context 'Go to edit form' do

    before :each do
      @category = FactoryGirl.create(:category)
      get edit_category_path(@category)
    end

    it 'request to a category' do 
      assigns(:category).should == @category
  	  expect(response).to render_template('edit')
    end

  end

  describe 'POST #create' do
    context 'When save sucessfully' do
      before :each do
        post :create, category: FactoryGirl.attributes_for(:category)
      end

      it 'save a category to the database' do
        expect{
          post :create, FactoryGirl.attributes_for(:category)
        }.to change(Category, :count).by 1
      end

    end
  end

  # context 'Go to delete form' do
  #   it 'request to delete a category' do
  #   	delete category_path('1')
  #   	expect(response).to render_template('destroy')
  #   end
  # end

end