FactoryGirl.define do
  factory :task do
    name 'Super task'
    done false

    trait :done do
      done true
    end
  end
end