Refinery::Blog::Post.class_eval do
  def html_body
    markdown_to_html(body)
  end

  def intro
    return custom_teaser if custom_teaser.present?
    markdown_to_html(body).strip_html_tags.truncate(100)
  end

  def should_generate_new_friendly_id?
    will_save_change_to_attribute?(:custom_url) || will_save_change_to_attribute?(:title)
  end

  private
  def markdown_to_html(markdown)
    @markdown_renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, fenced_code_blocks: true)
    @markdown_renderer.render(markdown)
  end
end
