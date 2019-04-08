class Page < ApplicationRecord
  validates :name, uniqueness: true, presence: true, format: { with: /[\wА-Яа-я]/ }
end
