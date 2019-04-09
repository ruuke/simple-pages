class Page < ApplicationRecord
  has_ancestry

  validates :name, uniqueness: true, presence: true, format: { with: /[\wА-Яа-я]/ }
end
