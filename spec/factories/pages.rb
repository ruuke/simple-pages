FactoryBot.define do
  sequence :name do |n|
    "Page#{n}"
  end

  factory :page do
    name
    title { "MyString" }
    body { "MyText" }

    trait :invalid do
      name { nil }
    end
  end
end
