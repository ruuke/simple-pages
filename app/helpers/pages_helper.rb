module PagesHelper
  # creating pages tree hierarchy with links
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

  # converting markdown to html
  def markdown(page)
    html_code = page.body
    # **[string]** => <b>[string]<?b>
    html_code.gsub!(/\*\*(?<bold>.*)\*\*/, '<b>\k<bold></b>')
    # //[string]// =>  <i>[string]</i>
    html_code.gsub!(/\\\\(?<ital>.*)\\\\/, '<i>\k<ital></i>')
    # ((name1/name2/name3 [string])) => <a href="[site]name1/name2/name3">[string]</a>
    html_code.gsub!(/\(\((?<link>.*) (?<name>.*)\)\)/, '<a href="/\k<link>">\k<name></a>') # ((name1/name2/name3 [string])) => name1/name2/name3 string

    html_code.html_safe
  end
end
