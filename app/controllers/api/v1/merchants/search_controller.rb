class Api::V1::Merchants::SearchController <ApplicationController 
    def most_items 
        render json: ItemsSoldSerializer.new(Merchant.find_best_selling_merchants(params[:quantity]))
    end
end