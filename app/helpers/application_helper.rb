require "will_paginate/view_helpers/action_view"

class MycustomLinkRenderer < WillPaginate::ActionView::LinkRenderer
  def page_number(page)
    extra_class = page == current_page ? "disabled" : ""
    tag(
      :li,
      link(page, page, rel: rel_value(page), class: "page-link"),
      class: "page-item #{extra_class}"
    )
  end

  def pagination
    @options[:page_links] ? windowed_page_numbers : []
  end

  def html_container(html)
    tag(:ul, html, container_attributes)
  end

  def url(page)
    @base_url_params ||= begin
                           url_params = merge_get_params(default_url_params)
                           merge_optional_params(url_params)
                         end

    url_params = @base_url_params.dup

    # Remove the locale
    url_params.delete(:locale)
    add_current_page_param(url_params, page)

    if /refinery/ === url_params[:controller]
      @template.refinery.url_for(url_params.merge({ only_path: true }))
    else
      @template.url_for(url_params)
    end
  end
end

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

    [fontawesome].join('').html_safe
  end

  # Custom the paginator
  def will_paginate(collection = nil, options = {})
    options, collection = collection, nil if collection.is_a? Hash
    collection ||= infer_collection_from_controller

    options = options.symbolize_keys
    options[:renderer] ||= MycustomLinkRenderer

    super(collection, options)
  end
end
