FactoryBot.define do
  factory :user do
    # sequence(:name) { |n| "TEST_NAME#{n}"}
    # sequence(:email) { |n| "TEST#{n}@example.com"}
    name { "one" }
    email { "one@exampe.com" }
    password { "aaaaaa" }
    admin {false}
  end
  factory :user2, class: User do
    name { "admin" }
    email { "admin@exampe.com" }
    password { "aaaaaa" }
    admin {true}
  end
end
