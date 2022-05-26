class Api::V1::MerchantsController <ApplicationController 
    def index 
        render json: MerchantSerializer.new(Merchant.all)
    end

    def show 
        render json: MerchantSerializer.new(Merchant.find(params[:id]))
    end

    def find
        if params[:name] == nil || params[:name] == ''
            render json: {}, status: 400 
        else 
            render json: MerchantSerializer.new(Merchant.find_by_name(params[:name]))
        end 
    end
end 