FactoryGirl.define do
  factory :note do |f|
    f.content "Lorem Ipsum"
    f.format "topdown"
    f.position 2
    f.association :user, factory: :user
  end
end
