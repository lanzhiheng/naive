require "rails_helper"

RSpec.describe "refinery/pages/home" do
  before(:each) do
    assign(:pages, [
             create(:home)
           ])
    assign(:posts, [
             create(:docker, draft: false),
             create(:ruby, draft: true)
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
end
