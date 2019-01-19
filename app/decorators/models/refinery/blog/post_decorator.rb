Refinery::Blog::Post.class_eval do
  # TODO: Bug of blog post.
  attr_accessor :browser_title
  attr_accessor :meta_description

  def html_body
    markdown_to_html(body)
  end

  def intro
    return custom_teaser if custom_teaser.present?
    Sanitize.fragment(markdown_to_html(body)).strip.truncate(100)
  end

  def should_generate_new_friendly_id?
    will_save_change_to_attribute?(:custom_url) || will_save_change_to_attribute?(:title)
  end

  class << self
    def search(search_string)
      includes(:translations).live.includes(:tags).where(
        'refinery_blog_post_translations.title ILIKE (?) OR
        refinery_blog_post_translations.body ILIKE (?) OR
        tags.name ILIKE (?)
        ',
        "%#{search_string}%",
        "%#{search_string}%",
        "%#{search_string}%"
      ).references(:tags)
    end
  end

  private
  def markdown_to_html(markdown)
    @markdown_renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, fenced_code_blocks: true)
    @markdown_renderer.render(markdown)
  end
end
