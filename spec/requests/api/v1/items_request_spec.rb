require 'rails_helper'

RSpec.describe "Item API " do 
    it 'gets all the items' do 
        create_list(:item, 10)

        get '/api/v1/items'
        expect(response).to be_successful

        items = JSON.parse(response.body, symbolize_names: true)
        expect(items[:data].count).to eq(10)

        items[:data].each do |item|
            
            expect(item).to have_key(:id)
            expect(item[:id]).to be_a(String)
            
            expect(item[:attributes]).to have_key(:name)
            expect(item[:attributes][:name]).to be_a(String)
            
            expect(item[:attributes]).to have_key(:description)
            expect(item[:attributes][:description]).to be_a(String)
            
            expect(item[:attributes]).to have_key(:unit_price)
            expect(item[:attributes][:unit_price]).to be_a(Float)
        end
    end

    it 'gets one merchant' do 
        create_list(:item, 5)
        items = Item.all
        get "/api/v1/items/#{items[2].id}"

        expect(response).to be_successful

        item = JSON.parse(response.body, symbolize_names: true)

        expect(item[:data][:id].to_i).to eq(items[2][:id])

        expect(item[:data][:attributes][:name]).to eq(items[2][:name])
        expect(item[:data][:attributes][:name]).to be_a(String)

    end

    it 'creates a new item' do
        merchant = create(:merchant)
        item_params = ({
        "name": "value1",
        "description": "value2",
        "unit_price": 100.99,
        "merchant_id": merchant.id
        })
        headers = {"CONTENT_TYPE" => "application/json"}

        post '/api/v1/items', headers: headers, params: JSON.generate(item: item_params)

        new_item = Item.last 
        
        expect(response).to be_successful
        expect(new_item.name).to eq("value1")
        expect(new_item.description).to eq("value2")
        expect(new_item.unit_price).to eq(100.99)
        expect(new_item.merchant_id).to eq("#{merchant.id}".to_i)
    end
end 