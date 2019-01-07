module Refinery
  PagesController.class_eval do
    before_action :load_categories
    before_action :load_posts, only: [:home]

    private
    def load_categories
      @categories = Refinery::Blog::Category.all
    end

    def load_posts
      @pages =  Refinery::Blog::Post.live.page(params[:page])
    end
  end
end
