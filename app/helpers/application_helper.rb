module ApplicationHelper
  def menu_list(current_path)
    Refinery::Page.fast_menu.map do |menu|
      path = menu.link_url.present? ? menu.link_url : "/#{menu.slug}"
      the_class = active_class(current_path, path)
      content_tag(:li, class: 'nav-item mx-2') do
        link_to(menu.title, path, class: "nav-link #{the_class}".strip)
      end
    end.join('').html_safe
  end

  def active_class(current_url, menu_path)
    if current_url == '/'
      return 'active' if menu_path == '/'
    else
      return 'active' if current_url.include?(menu_path) && menu_path != '/'
    end
    ''
  end
end
