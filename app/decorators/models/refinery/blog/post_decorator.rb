Refinery::Blog::Post.class_eval do
  def html_body
    markdown_to_html(body)
  end

  private
  def markdown_to_html(markdown)
    @markdown_renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, fenced_code_blocks: true)
    @markdown_renderer.render(markdown)
  end
end
