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

  # Some resource from external link
  def foreign_link_resource
    fontawesome = stylesheet_link_tag(
      "https://use.fontawesome.com/releases/v5.6.3/css/all.css",
      integrity: 'sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/',
      crossorigin: 'anonymous'
    )

    github_markdown = stylesheet_link_tag( "https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/2.10.0/github-markdown.css")

    [fontawesome, github_markdown].join('').html_safe
  end
end
