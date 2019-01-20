require "rails_helper"

module Refinery
  describe 'shared_layout_for_collection' do
    before(:each) do
      @docker = create(:docker, draft: false)
      @ruby = create(:ruby, draft: false)
      @basic = create(:basic)

      assign(:posts, Refinery::Blog::Post.page(1))
      assign(:categories, [
               create(:tech),
               create(:live)
             ])

      assign(:tag, create(:container))
    end

    def share_assert(template_name)
      render :template => template_name

      yield rendered if block_given?

      expect(rendered).to have_css('#main_content')
      expect(rendered).to have_content(@docker.title)
      expect(rendered).to have_content(@ruby.title)
      expect(rendered).to have_content(@basic.title)

      expect(rendered).to have_css('#sidebar')
      expect(rendered).to have_css('#about_wrapper')
      expect(rendered).to have_css('#search_wrapper')
      expect(rendered).to have_css('#categories_wrapper')
    end

    it "blog posts page" do
      share_assert 'refinery/blog/posts/index.html.erb'
      expect(rendered).not_to have_content('Searching:')
      expect(rendered).not_to have_content('Category:')
      expect(rendered).not_to have_content('Tag:')
    end

    it "search results page" do
      share_assert 'refinery/pages/_search.html.erb' do |rendered|
        expect(rendered).to have_content('Searching:')
      end
    end

    it "tagged results page" do
      share_assert 'refinery/blog/posts/tagged.html.erb' do |rendered|
        expect(rendered).to have_content('Tag:')
      end
    end

    it "categories results page" do
      share_assert 'refinery/blog/categories/show.html.erb' do |rendered|
        expect(rendered).to have_content('Category:')
      end
    end
  end
end
