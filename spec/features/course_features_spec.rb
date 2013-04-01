require 'spec_helper'

feature 'GET#Show' do
  scenario 'Show Courses' do

    objective = FactoryGirl.create(:objective, title: "Lesson 1")
    course = FactoryGirl.create(:course, title: "course1", objectives: [objective])
    category = FactoryGirl.create(:category, courses: [course])

    visit  category_path(category)

    within 'td#course_action_show' do
      click_link "Show"
    end

    visit course_path(course)
    page.should have_content "Course Overview"
    page.should have_content("course1")
    page.should have_content("Lesson 1")

    page.should have_content "Published"
    page.should have_link "Back"
  end

  scenario "Show Edit Form Objective" do
    objective = FactoryGirl.create(:objective, title: "Lesson 1")
    course = FactoryGirl.create(:course, title: "course1", objectives: [objective])
    category = FactoryGirl.create(:category, courses: [course])

    visit  category_path(category)

    within 'td#course_action_show' do
      click_link "Show"
    end

    visit course_path(course)

    within "td#action_edit_objective" do
      expect(page).to have_link "Edit"
      click_link "Edit"
    end

    current_path.should == edit_objective_path(objective)
    page.should have_content("Edit Objective")
  end

  scenario "Delete Objective" do
    objective = FactoryGirl.create(:objective, title: "Lesson 1")
    course = FactoryGirl.create(:course, title: "course1", objectives: [objective])
    category = FactoryGirl.create(:category, courses: [course])

    visit  category_path(category)

    within 'td#course_action_show' do
      click_link "Show"
    end

    visit course_path(course)

    within "td#action_delete_objective" do
      expect(page).to have_link "Delete"
      expect{
        click_link "Delete"
      }.to change(Objective, :count).by(-1)
    end
    page.should have_content("Course Overview")
    page.should have_content("course1")
    page.should_not have_content("Lesson1")

    page.should have_link "Back"
  end
end

feature 'POST#Create' do
  scenario 'Course Successfully' do
    category = FactoryGirl.create(:category, title: "HTML5 Mobile")
    visit category_path(category)

    click_link "Add New Course"
    visit new_course_path

    expect{
      select "HTML5 Mobile", :from => "course_category_id"
      fill_in "course_title", with: "HTML5"
      fill_in "course_short_title", with: "HTML"
      fill_in "course_duration", with: 7
      fill_in "course_cost_per_day", with: 10

      click_button "Save"
    }.to change(Course, :count).by(1)

    current_path.should == category_path(category)
    page.should have_content("Create Successfully.")
  end

  scenario 'Course failed' do
    category = FactoryGirl.create(:category, title: "HTML5 Mobile")
    visit category_path(category)

    click_link "Add New Course"
    visit new_course_path

    expect{
      select "HTML5 Mobile", :from => "course_category_id"
      fill_in "course_title", with: nil
      fill_in "course_short_title", with: "HTML"
      fill_in "course_duration", with: "7"
      fill_in "course_cost_per_day", with: "10"

      click_button "Save"
    }.not_to change(Course, :count).by(1)

    current_path.should == new_course_path
    page.should have_content("Create New Course")
  end

end

feature 'Edit#GET' do
  scenario 'Show Edit Form' do
    course = FactoryGirl.create(:course, title: 'B')
    category = FactoryGirl.create(:category, title: 'BBB', courses: [course])
    visit category_path(category)

    within "td#course_action_edit" do
      click_link "Edit"
    end
    visit edit_course_path(course)

    page.should have_content("#{course.title}")
    page.should have_link("Back")
  end

  scenario 'Update Successfully' do
    category = FactoryGirl.create(:category, title: 'BBB')
    course = FactoryGirl.create(:course, title: "course A")
    visit category_path(category)
    visit edit_course_path(course)
    # expect{
      fill_in "course_title", with: 'update title'
      click_button "Save"
      # within "td.action_update_rspec_save" do
      #   click_link "Save"
      # end
      
    # }
    # current_path.should == category_path(category)
  end

  scenario 'Update failed' do
    course = FactoryGirl.create(:course, title: "update failed")
    category = FactoryGirl.create(:category, title: 'BBB', courses: [course])
    visit category_path(category)
    visit edit_course_path(course)
    # expect{
      fill_in "course_title", with: 'update title'
      fill_in "Duration", with: nil
      click_button "Save"
    # }
    expect(page).to have_content("Published")
    expect(page).to have_button "Save"
  end
end

feature 'Delete' do
  scenario 'Course' do
    course = FactoryGirl.create(:course, title: "AAA")
    category = FactoryGirl.create(:category, title: "BBB", courses: [course])
    visit category_path(category)

    expect{
      within "td#course_action" do
        click_link "Delete"
      end
    }.to change(Course, :count).by(-1)

    current_path.should == category_path(category)
    page.should_not have_content "AAA"
  end
end