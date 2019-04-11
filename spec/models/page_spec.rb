require 'rails_helper'

RSpec.describe Page, type: :model do
  let(:page1) {create(:page, name: 'page1')}
  let(:page2) {create(:page, name: 'page2', parent_id: page1.id)}
  let(:page3) {create(:page, name: 'page3', parent_id: page2.id)}

  it { should validate_uniqueness_of :name }
  it { should validate_presence_of :name }
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should allow_value('abcABDабвАБВ123_').for(:name) }
  it { should_not allow_value('/-=').for(:name) }

  it 'adds parent slug' do
    expect(page2.slug).to eq('page1/page2')
    expect(page3.slug).to eq('page1/page2/page3')
  end

  it 'updates descendants slugs' do
    page1.update(name: 'page11')
    expect(page2.reload.slug).to eq('page11/page2')
    expect(page3.reload.slug).to eq('page11/page2/page3')
  end
end
