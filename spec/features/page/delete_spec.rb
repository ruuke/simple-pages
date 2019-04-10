require 'rails_helper'

feature 'User can delete page', %q{
  In order to delete page
  As any user
  I'd like to be able to delete page
} do
  given(:page1) { create :page }
  given(:page2) { create :page, parent_id: page1.id }

  scenario 'User deletes the page' do
    visit page_path(page2)

    click_on 'Delete'

    expect(page).to have_content "Pages list"
  end
end
