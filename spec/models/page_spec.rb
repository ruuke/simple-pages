require 'rails_helper'

RSpec.describe Page, type: :model do
  it { should validate_uniqueness_of :name }
  it { should validate_presence_of :name }
  it { should allow_value('abcABDабвАБВ123_').for(:name) }
  it { should_not allow_value('/-=').for(:name) }
end
