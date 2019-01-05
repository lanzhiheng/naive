# This will guess the User class
FactoryBot.define do
  factory :naive, class: Refinery::Authentication::Devise::User do
    username { "naive" }
    email { "naive@xxx.com" }
    password { 'naive' }
  end

  factory :evil, class: Refinery::Authentication::Devise::User do
    username { "evil" }
    email { "evil@xxx.com" }
    password { 'evil' }
  end

  factory :docker, class: Refinery::Blog::Post do
    association :author, factory: :naive
    title { "Docker" }
    body { "<div>Hello Docker</div>"}
    created_at { Time.now - 1.day }
    updated_at { Time.now - 1.day }
    published_at { Time.now - 1.day }
  end

  factory :ruby, class: Refinery::Blog::Post do
    association :author, factory: :evil
    title { "Ruby" }
    body { "<div>Hello Ruby</div>"}
    created_at { Time.now - 1.day }
    updated_at { Time.now - 1.day }
    published_at { Time.now - 1.day }
  end
end
