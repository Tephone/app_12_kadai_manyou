FactoryBot.define do
  factory :tag do
    tag_name { "sample1" }
  end
  factory :tag2, class: Tag do
    tag_name { "sample2" }
  end
end
