require 'spec_helper'

feature 'Home page' do
  scenario 'Listing All Category and Courses' do
    course = FactoryGirl.create(:course, title: 'Variable')
    category = FactoryGirl.create(:category, title: 'Ruby', courses: [course])
    visit root_path

    expect(page).to have_link("Add New Category")

    expect(page).to have_content("Computer Programming Course")
    expect(page).to have_content("Ruby")
    expect(page).to have_content("Variable")
  end

  scenario "Click Add New Category Link" do
    visit root_path
    click_link "Add New Category"
    visit new_category_path
    expect(page).to have_content("Create New Category")
  end

  scenario "Click Each Category item to show courses and Each Course to show course overview" do
    course = FactoryGirl.create(:course, title: 'Variable')
    category = FactoryGirl.create(:category, title: 'Ruby', courses: [course])

    #Click on Category then show courses of category
    visit root_path
    click_link "Ruby"
    visit category_path(category)
      expect(page).to have_content("Ruby")
      expect(page).to have_content("Variable")
      expect(page).to have_link("Edit")
      expect(page).to have_link("Delete")
      expect(page).to have_link("Show")
      expect(page).to have_link("Add New Course")

    #Click on course then show course overview
    visit root_path
    click_link "Variable"
    visit course_path(course)
    expect(page).to have_content("Variable")
    expect(page).to have_link("Course Objective")
    expect(page).to have_content("Course Overview")
    expect(page).to have_link("Back")
  end

end