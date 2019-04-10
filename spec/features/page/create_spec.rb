require 'rails_helper'

feature 'User can create page', %q{
  In order to create page content
  As any user
  I'd like to be able to create page
} do
  describe 'User' do
    background do
      visit root_path
      click_on 'New page'
    end

    scenario 'create a page' do
      fill_in 'Name', with: 'Page1'
      fill_in 'Title', with: 'MyTitle'
      fill_in 'Body', with: 'text'
      click_on 'Create Page'

      expect(page).to have_content 'MyTitle'
      expect(page).to have_content 'text'
    end

    scenario 'creates a page with errors' do
      click_on 'Create Page'

      expect(page).to have_content "Name can't be blank"
    end
  end
end
