module Refinery
  PagesController.class_eval do
    before_action :load_categories

    private
    def load_categories
      @categories = Refinery::Blog::Category.all
    end
  end
end
