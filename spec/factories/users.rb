FactoryGirl.define do

  factory :user do |f|
    f.sequence(:username)  { |n| "Person_#{n}" }
    f.email { |n| "#{n.username}_#{rand(1000).to_s}@example.com" }
    f.password "foobar1"
    f.password_confirmation "foobar1"
  end
   
end
