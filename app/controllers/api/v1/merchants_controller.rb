class Api::V1::MerchantsController <ApplicationController 
    def index 
        Merchant.all 
    end
end