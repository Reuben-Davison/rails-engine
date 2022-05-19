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
    it 'updates an item' do
        merchant = create(:merchant)
        item = create(:item)
        old_name = item.name 
        old_price = item.unit_price

        item_params = ({
        "name": "new_name",
        "unit_price": 500.12,
        })

        headers = {"CONTENT_TYPE" => "application/json"}
        patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item: item_params)

        updated_item = Item.find_by(id: item.id) 
        
        expect(response).to be_successful
        expect(updated_item.name).to eq("new_name")
        expect(updated_item.name).to_not eq(old_name)
        expect(updated_item.unit_price).to_not eq(old_price)
        expect(updated_item.unit_price).to eq(500.12)
    end

    it 'can delete an item' do 
        merchant = create(:merchant)
        item = create(:item)

        delete "/api/v1/items/#{item.id}"

        expect(response).to be_successful
        expect(Item.count).to eq(0)
    end

    it 'can find all the items that match a name search query' do 
        create_list(:item, 5, unit_price: 15 )
        create_list(:item, 5, unit_price: 25 )
        item1 = create(:item, name: 'copysnap', unit_price: 20)
        item2 = create(:item, name: 'copysnapvip', unit_price: 19)
        item3 = create(:item, name: 'vipcopysna', unit_price: 23)

        get '/api/v1/items/find_all?name=copysna'
        expect(response).to be_successful
        item_response = JSON.parse(response.body, symbolize_names: true)
        
        expect(item_response[:data].count).to eq(3)
        item_response[:data].each do |item|
            binding.pry
            expect(item[:attributes][:name].include?("copysn")).to eq true 
        end
        

    end
end 