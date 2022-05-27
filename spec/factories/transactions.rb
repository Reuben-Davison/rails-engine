FactoryBot.define do
  factory :transaction do
    association :invoice

    result { "success" || "failed"}
  end 
end