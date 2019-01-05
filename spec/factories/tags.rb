# This will guess the User class
FactoryBot.define do
  factory :container, class: ActsAsTaggableOn::Tag do
    name { 'container' }
  end

  factory :rails, class: ActsAsTaggableOn::Tag do
    name { 'rails' }
  end

  factory :language, class: ActsAsTaggableOn::Tag do
    name { 'language' }
  end
end
