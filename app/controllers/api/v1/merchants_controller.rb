class Api::V1::MerchantsController <ApplicationController 
    def index 
        render json: MerchantSerializer.new(Merchant.all)
    end

    def show 
        binding.pry
        render json: MerchantSerializer.new(Merchant.find(params[:id]))
    end

    def find
         render json: MerchantSerializer.new(Merchant.find_by_name(params[:name]))
    end
end 