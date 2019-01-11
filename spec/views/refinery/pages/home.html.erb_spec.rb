require "rails_helper"

RSpec.describe "refinery/pages/home" do
  before(:each) do
    assign(:pages, [
             create(:home)
           ])

    # tag
    @container = build(:container)
    @rails = build(:rails)
    @language = build(:language)
    # post
    @docker = create(:docker, draft: false, custom_teaser: "Teaser for docker")
    @ruby = create(:ruby, draft: false, custom_teaser: "")

    @docker.tags << [@container, @language]
    @ruby.tags << [@rails, @language]

    assign(:posts, [
             @docker,
             @ruby
           ])
    assign(:categories, [
             create(:tech),
             create(:live),
           ])
  end

  it "displays categories in home page" do
    render
    expect(rendered).to match(/<h6 class="card-title">Category<\/h6>/)
    expect(rendered).to match(/href="#{refinery.blog_category_path(build(:tech))}"/)
    expect(rendered).to match(/href="#{refinery.blog_category_path(build(:live))}"/)
  end

  it "display posts in home page" do
    render
    expect(rendered).to have_selector('.card.post')
    # title
    expect(rendered).to have_text(@docker.title)
    expect(rendered).to have_text(@ruby.title)

    # tag
    expect(rendered).to have_text(@container.name)
    expect(rendered).to have_text(@rails.name)
    expect(rendered).to have_text(@language.name)

    # Teaser
    expect(rendered).to have_text(@docker.custom_teaser)
    expect(rendered).to have_text("Without teaser now.")
  end
end
