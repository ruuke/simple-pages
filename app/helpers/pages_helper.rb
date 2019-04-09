module PagesHelper
  # генерация дерева страниц и подстраниц с помощью маркированного списка
  def display_tree(page)
    tree = "<li>#{link_to page.name, pages_path(page)}</li>"
    if page.has_children?
      tree += "<ul>"
      page.children.each do |sub_page|
        tree += "#{display_tree(sub_page)}"
      end
      tree += "</ul>"
    end
    tree.html_safe
  end

  # создание пути из ссылок вида Page 1 > Page 1.1 > ...
  def make_path(page)
    page.ancestors.map do |parent|
      link_to parent.name, nested_pages_path(parent)
    end.join(' > ').html_safe
  end
end
