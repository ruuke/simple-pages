require 'rails_helper'

RSpec.describe Page, type: :model do
  it { should validate_uniqueness_of :name }
  it { should validate_presence_of :name }
  it { should allow_value('abcABDабвАБВ123_').for(:name) }
  it { should_not allow_value('/-=').for(:name) }

  it 'it add parent slug' do
    page1 = Page.create(name: 'page1')
    page2 = Page.create(name: 'page2', parent_id: page1.id)
    expect(page2.slug).to eq('page1/page2')
  end

  it 'updates descendants slugs' do
    page1 = Page.create(name: 'page1')
    page2 = Page.create(name: 'page2', parent_id: page1.id)
    page1.update(name: 'page11')
    # page1.run_callbacks :save
    # allow(page1).to receive(:update_descendants_slugs)
    page1.send(:update_descendants_slugs)
    page1.send(:has_children?)
    # expect(page1.slug).to eq('page11')
    expect(page2.slug).to be('page11/page2')
  end
end
