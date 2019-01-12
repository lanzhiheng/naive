require "rails_helper"

module Refinery
  module Blog
    describe Post, :type => :model do
      before(:all) do
        @markdown_renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, fenced_code_blocks: true)
      end

      it "html_body method" do
        post = create(:ruby)
        expect(post.html_body).to eq(@markdown_renderer.render(post.body))
      end
    end
  end
end
