FactoryGirl.define do # is not creating classes, it is creating instances of those classes, in this case instance of `User` class
  factory :user do
    email {FFaker::Internet.email }
    password "12345678"
    password_confirmation "12345678"
  end
end
