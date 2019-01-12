Refinery::Blog::Post.class_eval do
  def html_body
    markdown_to_html(body)
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
