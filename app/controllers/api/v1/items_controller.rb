class Api::V1::ItemsController <ApplicationController 
    def index 
        merchant = Merchant.find(params[:merchant_id])
        render json: ItemSerializer.new(merchant.items)
    end
end