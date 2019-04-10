require 'rails_helper'

feature 'User can view page content', %q{
  In order to view page content
  As any user
  I'd like to be able to view page
} do
  given(:page1) { create :page }
  given(:page2) { create :page, parent_id: page1.id }

  scenario 'User views the page' do
    visit page_path(page2)

    expect(page).to have_content "#{page2.title}"
    expect(page).to have_content "#{page2.body}"
  end
end
