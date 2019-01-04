# This will guess the User class
FactoryBot.define do
  factory :tech, class: Refinery::Blog::Category do
    title { "Tech" }
    slug { 'tech' }
  end

  factory :live, class: Refinery::Blog::Category do
    title { "Live" }
    slug { 'live' }
  end

  factory :read, class: Refinery::Blog::Category do
    title { "Read" }
    slug { 'read' }
  end
end

