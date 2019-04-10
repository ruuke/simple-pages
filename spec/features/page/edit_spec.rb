require 'rails_helper'

feature 'User can edit page content', %q{
  In order to change page content
  As any user
  I'd like to be able to edit page
} do
  given(:page1) { create :page }
  given(:page2) { create :page, parent_id: page1.id }

  describe 'User' do
    background do
      visit page_path(page2)

      click_on 'Update'
    end

    scenario 'edit the page' do
      fill_in 'Title', with: 'NewTitle'
      fill_in 'Body', with: 'newtext'
      click_on 'Update Page'

      expect(page).to have_content 'NewTitle'
      expect(page).to have_content 'newtext'
    end

    scenario 'edit the page with errors' do
      fill_in 'Name', with: ''

      click_on 'Update Page'

      expect(page).to have_content "Name can't be blank"
    end
  end
end
