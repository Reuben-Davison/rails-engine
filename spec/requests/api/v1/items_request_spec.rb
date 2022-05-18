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
end 