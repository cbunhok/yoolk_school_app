require 'spec_helper'

feature "POST#Create" do
  scenario "Category Successfully" do
    visit new_category_path
    expect{
      fill_in "category_title", with: "Web Development"
      fill_in "Description", with: "Learning Web Development"
      click_button "Save"
    }.to change(Category, :count).by(1)

    current_path.should == root_path
    expect(page).to have_content("Create Successfully.")
  end

  scenario "Category not Successfully" do
    visit new_category_path
    expect{
      fill_in "Title", with: nil
      fill_in "Description", with: "AAA"
      click_button "Save"
    }.not_to change(Category, :count).by(1)

    current_path.should == new_category_path
  end

end

feature "Edit#GET" do
  scenario "Show Edit Form" , :focus do
    category = FactoryGirl.create(:category, title: 'Web', description: 'Web')
    category

    # visit category_path(category)
    visit edit_category_path(category)
    expect(page).to have_content("Edit Category")
    expect(page).to have_link("Back")
  end

  scenario "Update Category Successfully" do
    category = FactoryGirl.create(:category, title: 'web', description: 'web-pros')
    visit category_path(category)
    visit edit_category_path(category)

    # expect{
    fill_in "Title", with: "AAA"
    click_button "Save"
    # }

    current_path.should == category_path(category)
    expect(page).to have_content("Update Successfully.")
  end

  scenario "Update Category failed" do
    category = FactoryGirl.create(:category, title: 'web', description: 'web-pros')
    visit category_path(category)
    visit edit_category_path(category)

    fill_in "Title", with: nil
    click_button "Save"

    #current_path.should == edit_category_path(category)
    expect(page).to have_content('Edit Category')
  end

end

feature 'Delete' do
  scenario 'Category Successfully' do
    category = FactoryGirl.create(:category, :title => 'AAA')

    visit category_path(category)
    expect{
      click_link 'Delete'
    }.to change(Category, :count).by(-1)

    current_path.should == root_path
    page.should have_content "Computer Programming Course"
    page.should_not have_content "AAA"
  end
end