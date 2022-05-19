require 'rails_helper'

RSpec.describe "Item merchant API " do 
    it "gets the info of a item's merchant" do 
        non_merchants = create_list(:merchant, 5)
        item = create(:item)
        binding.pry
        get "/api/v1/items/#{item.id}/merchant"
        expect(response).to be_successful

        merchant_info = JSON.parse(response.body, symbolize_names: true)

    
    end
end 
