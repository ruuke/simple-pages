module PagesHelper
  # создание дерева иерархии страниц из ссылок страниц
  def show_tree(page)
    tree = "<li>#{link_to page.name, subpage_path(page)}</li>"
    if page.has_children?
      tree += "<ul>"
      page.children.each do |page|
        tree += "#{show_tree(page)}"
      end
      tree += "</ul>"
    end
    tree.html_safe
  end

  #конвертация markdown в html
  def markdown(page)
    html_code = page.body
    # **[строка]** => <b>[строка]<?b>
    html_code.gsub!(/\*\*(?<bold>.*)\*\*/, '<b>\k<bold></b>')
    # //[строка]// =>  <i>[строка]</i>
    html_code.gsub!(/\\\\(?<ital>.*)\\\\/, '<i>\k<ital></i>')
    # ((name1/name2/name3 [строка])) => <a href="[site]name1/name2/name3">[строка]</a>
    html_code.gsub!(/\(\((?<link>.*) (?<name>.*)\)\)/, '<a href="/\k<link>">\k<name></a>') # ((name1/name2/name3 [строка])) => name1/name2/name3, строка

    html_code.html_safe
  end
end
