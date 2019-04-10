require 'rails_helper'

feature 'User can visit index page', %q{
  In order to view page hierarchy
  As any user
  I'd like to be able to visit index page
} do
  given!(:page1) { create :page }
  given!(:page2) { create :page, name: '123', parent_id: page1.id }

  scenario 'User views index page' do
    visit root_path

    expect(page).to have_link(href: "/#{page1.slug}")
    expect(page).to have_link(href: "/#{page2.slug}")
  end
end
