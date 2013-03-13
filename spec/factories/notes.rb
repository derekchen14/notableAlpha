FactoryGirl.define do
  factory :note do |f|
    f.content "Lorem Ipsum"
    f.format "topdown"
    f.association :user
  end
end
