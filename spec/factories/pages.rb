# This will guess the User class
FactoryBot.define do
  factory :home, class: Refinery::Page do
    title { "home" }
    show_in_menu { true }
    link_url { '/' }
    slug { '/' }
  end

  factory :blog, class: Refinery::Page do
    title { "blog" }
    show_in_menu { true }
    slug { '/blog' }
  end

  factory :about, class: Refinery::Page do
    title { "about" }
    show_in_menu { false }
    slug { '/about' }
  end
end

