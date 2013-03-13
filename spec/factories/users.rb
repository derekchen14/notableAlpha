FactoryGirl.define do

  factory :user do |f|
    f.sequence(:username)  { |n| "Person #{n}" }
    f.sequence(:email) { |n| "person_#{n}@example.com"}   
    f.password "foobar1"
    f.password_confirmation "foobar1"
  end
   
end
