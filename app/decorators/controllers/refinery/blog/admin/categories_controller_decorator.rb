module Refinery
  module Blog
    module Admin
      CategoriesController.class_eval do
        private

        def category_params
          params.require(:category).permit(:title, :slug)
        end
      end
    end
  end
end
