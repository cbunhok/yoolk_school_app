require 'spec_helper'

feature 'GET#Show' do
  scenario 'Objective Show' do
    objective = FactoryGirl.create(:objective, title: "Array" )
    category = FactoryGirl.create(:category)
    course = FactoryGirl.create(:course, title: "Course", :objectives => [objective])
    
    visit category_path(category)
    visit course_path(course)
    visit objective_path(course)
    expect{
      within "btn.btn-info" do
        click_link "Create New Objective"
      end
      within "th.action_show_spec" do
        have_content "Objectives of #{course.title}"
      end
    }
    expect(page).to have_content "Course Objective for #{course.title}"
    expect(page).to have_link "Add New Objective"
  end
end

feature 'GET#New' do 
  scenario 'Objective' do
    course = FactoryGirl.create(:course, title:"Course")
    category = FactoryGirl.create(:category, :courses => [course])
    objective = FactoryGirl.create(:objective, title: "Array" )
    

    visit category_path(category)
    expect(page).to have_link "Show"
    visit course_path(course)
    expect(page).to have_link "Create New Objective"
    visit objective_path(course)
    expect(page).to have_content "Course Objective for #{course.title}"
    expect{
      within "td.action_create" do  
        expect(page).to have_content "Title :"
        click_link "Save"
        current_path.should == course_path(course)
      end
    }
  end
end 

feature 'POST#create' do
  scenario 'Objective Successfully' do
    course = FactoryGirl.create(:course, title: 'Ruby')
    objective = FactoryGirl.create(:objective, title: 'AAA', description:"Web Dev")
    category = FactoryGirl.create(:category)

    visit category_path(category)
    visit course_path(course)
    visit objective_path(course)
    visit new_objective_path(objective)
    expect{
      page.should have_content "Create New Objective"
      select "Ruby", :from => "objective_course_id" 
      fill_in "objective_title", with: "Ruby"
      fill_in "objective_description", with: "Web Dev"
      click_button "Save"
    }.to change(Objective, :count).by(1)

    current_path.should == course_path(course)
  end

  scenario 'Objective Failed' do
    course = FactoryGirl.create(:course, title: 'Ruby')
    objective = FactoryGirl.create(:objective, title: 'AAA', description:"Web Dev")
    category = FactoryGirl.create(:category)

    visit category_path(category)
    visit course_path(course)
    visit objective_path(course)
    visit new_objective_path(objective)
    expect{
      page.should have_content "Create New Objective"
      select "Ruby", :from => "objective_course_id" 
      fill_in "objective_title", with: nil
      fill_in "objective_description", with: "Web Dev"
      click_button "Save"
    }.to change(Objective, :count).by(0)
  end
end

feature 'GET# Edit' do
  scenario 'Objective Successfully' do
    objective = FactoryGirl.create(:objective, title: 'AAA', description:"Web")
    course = FactoryGirl.create(:course, objectives: [objective], title: 'Ruby')
    category = FactoryGirl.create(:category)

    visit category_path(category)
    visit objective_path(course)
    expect(page).to have_content "Course Objective for #{course.title}"
    click_link "Edit"
    expect(page).to have_content "Edit Objective"
    expect(page).to have_content "Course"
  end 
end

feature 'PUT# Update' do
  scenario 'Objective Successfully' do
    objective = FactoryGirl.create(:objective, title: 'AAA', description:"Web")
    course = FactoryGirl.create(:course, objectives: [objective], title: 'Ruby')
    category = FactoryGirl.create(:category)

    visit category_path(category)
    visit objective_path(course)
    expect(page).to have_content "Course Objective for #{course.title}"
    click_link "Edit"
    expect(page).to have_content "Edit Objective"
    expect(page).to have_content "Course"

      fill_in "Title", with: 'update title'
      click_button "Save"

    current_path.should == course_path(course)
  end 

  scenario 'Objective Failed' do
    objective = FactoryGirl.create(:objective, title: 'AAA', description:"Web")
    course = FactoryGirl.create(:course, objectives: [objective], title: 'Ruby')
    category = FactoryGirl.create(:category)

    visit category_path(category)
    visit objective_path(course)
    expect(page).to have_content "Course Objective for #{course.title}"
    click_link "Edit"
    expect(page).to have_content "Edit Objective"
    expect(page).to have_content "Course"

      fill_in "Title", with: nil
      click_button "Save"

    current_path.should == edit_objective_path(objective)
  end 
end

feature 'DELETE# Destroy' do 
  scenario 'Objective Successfully' do 
    objective = FactoryGirl.create(:objective, title: 'AAA', description:"Web")
    course = FactoryGirl.create(:course, objectives: [objective], title: 'Ruby')
    category = FactoryGirl.create(:category)

    visit category_path(category)
    visit objective_path(course)
    expect(page).to have_content "Course Objective for #{course.title}"
    
    expect {
      within "td#objective_action" do
        click_link "Delete"
      end
    }.to change(Objective, :count).by(-1)
    current_path.should == course_path(course)
  end
end
