class Page < ApplicationRecord
  # подключение библиотеки для использования имен вместо id+добавление поля slug
  extend FriendlyId
  friendly_id :name, use: :slugged

  # добавление родительского поля ancestry в таблицу Page для вложенных страниц
  has_ancestry

  validates :name,  uniqueness: true,
                    presence: true,
                    format: { with: /[\wА-Яа-я]/ }

  after_save :update_descendants_slugs

  # метод gem'a Friendli_id,
  # создание транслита, если имя введено на русском, и добавление родительского slug'a
  def normalize_friendly_id(name)
    name_as_slug = name.to_s.to_slug.normalize(transliterations: :russian).to_s
    add_parent_slug(name_as_slug)
  end


  # метод gem'a Friendli_id, обновляет slug
  def should_generate_new_friendly_id?
    name_changed?
  end

  private

  # если у страницы есть вложенные страницы, то обновляем slug'и всех потомков
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
