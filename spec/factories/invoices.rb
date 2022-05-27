FactoryBot.define do
  factory :invoice do
    association :merchant, :customer

    status { "shipped" || "pending"}
  end 
end