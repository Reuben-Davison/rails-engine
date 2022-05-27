FactoryBot.define do
    factory :invoice_items do 
        association :item, :invoice 
        quantity { 1..10}
        unit_price { Faker::Commerce.price }
    end
end