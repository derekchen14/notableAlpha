FactoryGirl.define do
  factory :tag do |f|
    f.name "my_tag"
    f.association :user, factory: :user
  end
end
