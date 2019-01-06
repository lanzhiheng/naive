module Refinery
  module Blog
    PostsController.class_eval do
      def tagged_by_name
        # TODO Fix N + 1
        @tag = ActsAsTaggableOn::Tag.find_by!(name: params[:tag_name])
        @posts = Refinery::Blog::Post.live.tagged_with(@tag.name).page(params[:page])
        render :tagged
      end
    end
  end
end
