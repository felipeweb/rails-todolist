FactoryGirl.define do
  factory :list do
    name 'New list'
    public false
    done true
    user_id 1

    trait :public do
      public true
      done true
      user_id 1
    end
  end
end