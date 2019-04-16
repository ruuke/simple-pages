FactoryBot.define do
  factory :page do
    name { 'page' }
    title { "MyString" }
    body { "MyText" }

    trait :invalid do
      name { nil }
    end
  end
end
