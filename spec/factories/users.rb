FactoryGirl.define do

  factory :user do |f|
    f.sequence(:username)  { |n| "Person_#{n}" }
    f.email { |n| "#{n.username}@example.com" }
    f.password "foobar1"
    f.password_confirmation "foobar1"
  end
   
end
