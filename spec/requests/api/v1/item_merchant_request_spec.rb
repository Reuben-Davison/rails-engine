require 'rails_helper'

RSpec.describe "Item merchant API " do 
    it "gets the info of a item's merchant" do 
        non_merchants = create_list(:merchant, 5)
        item = create(:item)
        get "/api/v1/items/#{item.id}/merchant"
        expect(response).to be_successful

        merchant_info = JSON.parse(response.body, symbolize_names: true)
        expect(merchant_info[:data][:attributes][:name]).to eq(item.merchant.name)
        
        non_merchants.each do |merchant|
            expect(merchant.name).to_not be_in(merchant_info)
        end

    
    end
end 
