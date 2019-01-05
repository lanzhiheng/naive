# This will guess the User class
FactoryBot.define do
  factory :naive, class: Refinery::Authentication::Devise::User do
    username { "naive" }
    email { "naive@xxx.com" }
    password { 'naive' }
  end

  factory :docker, class: Refinery::Blog::Post do
    association :author, factory: :naive, strategy: :build
    title { "Docker" }
    body { "<div>Hello Docker</div>"}
    created_at { Time.now - 1.day }
    updated_at { Time.now - 1.day }
    published_at { Time.now - 1.day }
  end

  factory :ruby, class: Refinery::Blog::Post do
    association :author, factory: :naive, strategy: :build
    title { "Ruby" }
    body { "<div>Hello Ruby</div>"}
    created_at { Time.now - 1.day }
    updated_at { Time.now - 1.day }
    published_at { Time.now - 1.day }
  end
end
