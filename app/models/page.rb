class Page < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_ancestry

  validates :slug, :name, uniqueness: true, presence: true, format: { with: /[\wА-Яа-я]/ }

  def normalize_friendly_id(name)
    name_as_slug = name.to_s.to_slug.normalize(transliterations: :russian).to_s
    if has_parent?
      slug = [parent.slug, name_as_slug].join('/')
    else
      slug = name_as_slug
    end
  end

  def should_generate_new_friendly_id?
    name_changed?
  end
end
