require "will_paginate/view_helpers/action_view"

module WillPaginate
  module ActionView
    class LinkRenderer < ViewHelpers::LinkRenderer
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
  end
end
