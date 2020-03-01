FactoryBot.define do
  sequence(:body) { |n| "message_#{n}_body" }

  factory :message do
    user
    body { generate :body }

    trait :personal do
      addressee_id { create(:user).id }
    end
  end
end
