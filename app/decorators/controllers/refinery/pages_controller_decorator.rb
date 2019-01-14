module Refinery
  PagesController.class_eval do
    before_action :load_categories
    before_action :load_posts, only: [:home]
    before_action :load_search, if: -> { request.path == '/search' }

    private
    def load_search
      @posts = Refinery::Blog::Post.search(params[:q]).page(params[:page])
    end

    def load_categories
      @categories = Refinery::Blog::Category.all
    end

    def load_posts
      @posts =  Refinery::Blog::Post.live.page(params[:page])
    end
  end
end
