require 'rails_helper'

feature 'User can edit page content', %q{
  In order to change page content
  As any user
  I'd like to be able to edit page
} do
  given(:page1) { create :page }
  given(:page2) { create :page, name: '123', parent_id: page1.id }

  describe 'User' do
    background do
      visit page_path(page2)

      click_on 'Update'
    end

    scenario 'edit the page' do
      fill_in 'Title', with: 'NewTitle'
      fill_in 'Body', with: '**[строка]** \\\[строка]\\\ ((name1/name2/name3 [строка]))'
      click_on 'Update Page'

      within('b') do
        expect(page).to have_content '[строка]'
      end

      within('i') do
        expect(page).to have_content '[строка]'
      end

      expect(page).to have_link(href: "/name1/name2/name3")
      expect(page).to have_content 'NewTitle'
    end

    scenario 'edit the page with errors' do
      fill_in 'Name', with: ''

      click_on 'Update Page'

      expect(page).to have_content "Name can't be blank"
    end
  end
end
