require 'rails_helper'

RSpec.describe "Merchant API " do 
    it 'gets all the merchants' do 
        create_list(:merchant, 5)

        get '/api/v1/merchants'

        expect(response).to be_successful
        expect(response.count). to eq(5)
    end
end