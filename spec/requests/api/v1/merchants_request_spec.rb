require 'rails_helper'

RSpec.describe "Merchant API " do 
    it 'gets all the merchants' do 
        create_list(:merchant, 5)

        get '/api/v1/merchants'
        expect(response).to be_successful

        merchants = JSON.parse(response.body, symbolize_names: true)
        expect(merchants[:data].count).to eq(5)

        merchants[:data].each do |merchant|
            expect(merchant).to have_key(:id)
            expect(merchant[:id]).to be_an(String)

            expect(merchant[:attributes]).to have_key(:name)
            expect(merchant[:attributes][:name]).to be_an(String)
        end
    end

    it 'gets one merchant' do 
        merchants = create_list(:merchant, 5)
        get "/api/v1/merchants/#{merchants[2].id}"

        expect(response).to be_successful

        merchant = JSON.parse(response.body, symbolize_names: true)

        expect(merchant[:data][:id].to_i).to eq(merchants[2][:id])
        expect(merchant[:data][:attributes][:name]).to eq(merchants[2][:name])
        expect(merchant[:data][:attributes][:name]).to be_a(String)

    end

    it 'can retrieve the info for a single merchant in a query search' do 
        merchants = create_list(:merchant, 10)


    end
end