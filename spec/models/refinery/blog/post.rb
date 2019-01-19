require "rails_helper"

module Refinery
  module Blog
    describe Post, :type => :model do
      before(:all) do
        @markdown_renderer ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, fenced_code_blocks: true)
      end

      it "search scope by title" do
        post1 = create(:ruby, body: "I am ruby", draft: false)
        post2 = create(:docker, body: "I am docker", draft: false)

        result = Refinery::Blog::Post.search(post1.title)
        expect(result.size).to eq(1)
        expect(result).to include(post1)
        expect(result).not_to include(post2)

        result = Refinery::Blog::Post.search('asdkfljasdkflasjdfalsdkf')
        expect(result.size).to eq(0)
      end

      context "case insensitive" do
        before(:all) do
        end
      end

      it "search scope case insensitive" do
        post1 = create(:ruby, draft: false)
        post2 = create(:docker, draft: false)
        tag1 = create(:rails)
        post1.tags << tag1

        result = Refinery::Blog::Post.search(post1.title.upcase)
        expect(result.size).to eq(1)
        expect(result).to include(post1)
        expect(result).not_to include(post2)

        result = Refinery::Blog::Post.search(post1.title.downcase)
        expect(result.size).to eq(1)
        expect(result).to include(post1)
        expect(result).not_to include(post2)

        result = Refinery::Blog::Post.search(post1.body.upcase)
        expect(result.size).to eq(1)
        expect(result).to include(post1)
        expect(result).not_to include(post2)

        result = Refinery::Blog::Post.search(post1.body.downcase)
        expect(result.size).to eq(1)
        expect(result).to include(post1)
        expect(result).not_to include(post2)

        result = Refinery::Blog::Post.search(tag1.name.upcase)
        expect(result.size).to eq(1)
        expect(result).to include(post1)
        expect(result).not_to include(post2)

        result = Refinery::Blog::Post.search(tag1.name.downcase)
        expect(result.size).to eq(1)
        expect(result).to include(post1)
        expect(result).not_to include(post2)
      end

      it "search scope by body" do
        post1 = create(:basic, title: 'one', body: "I am ruby", draft: false)
        post2 = create(:basic, title: 'two', body: "I am docker", draft: false)

        result = Refinery::Blog::Post.search('ruby')
        expect(result.size).to eq(1)
        expect(result).to include(post1)
        expect(result).not_to include(post2)

        result = Refinery::Blog::Post.search('I am')
        expect(result.size).to eq(2)
        expect(result).to include(post1)
        expect(result).to include(post2)

        result = Refinery::Blog::Post.search('asdfasldkfjaslkdf')
        expect(result.size).to eq(0)
      end

      it "search scope by tags" do
        post1 = create(:basic, title: 'x1', draft: false)
        post2 = create(:basic, title: 'x2', draft: false)
        tag1 = create(:rails)
        tag2 = create(:language)

        result = Refinery::Blog::Post.search(tag1.name)
        expect(result.size).to eq(0)

        result = Refinery::Blog::Post.search(tag2.name)
        expect(result.size).to eq(0)

        # Add tag
        post1.tags << tag1
        post2.tags << tag2

        result = Refinery::Blog::Post.search(tag1.name)
        expect(result.size).to eq(1)
        expect(result).to include(post1)
        expect(result).not_to include(post2)

        result = Refinery::Blog::Post.search(tag2.name)
        expect(result.size).to eq(1)
        expect(result).to include(post2)
        expect(result).not_to include(post1)
      end

      it "html_body method" do
        post = create(:ruby)
        expect(post.html_body).to eq(@markdown_renderer.render(post.body))
      end

      it "intro method" do
        post = create(:ruby, custom_teaser: '', body: '<h1>lanzhiheng</h1>' * 10)
        body = Sanitize.fragment(@markdown_renderer.render(post.body)).strip
        expect(post.intro).to eq(body.truncate(100))

        post.custom_teaser = 'Hello World'
        expect(post.intro).to eq('Hello World')
      end
    end
  end
end
