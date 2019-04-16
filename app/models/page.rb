class Page < ApplicationRecord
  # connecting the library to use names instead of id + adding a slug field
  extend FriendlyId
  friendly_id :name, use: :slugged

  # add parent ancestry field to Page for nested pages
  has_ancestry

  validates :title, :body, presence: true

  validates :name,  uniqueness: true,
                    presence: true,
                    format: { with: /[\wА-Яа-я]/ }

  after_save :update_descendants_slugs

  # gem Friendli_id method,
  # create transliteration, if the name is entered in Russian, and add parent slug
  def normalize_friendly_id(name)
    name_as_slug = name.to_s.to_slug.normalize(transliterations: :russian).to_s
    add_parent_slug(name_as_slug)
  end

  # gem Friendli_id method, updates slug
  def should_generate_new_friendly_id?
    name_changed?
  end

  private

  # if the page has nested pages, then update slugs of all descendants
  def update_descendants_slugs
    if has_children?
      descendants.each do |child|
        child.slug = [child.parent.slug, child.slug.split('/').last].join('/')
        child.save!
      end
    end
  end

  def add_parent_slug(name_as_slug)
    if has_parent?
      slug = [parent.slug, name_as_slug].join('/')
    else
      slug = name_as_slug
    end
  end
end
