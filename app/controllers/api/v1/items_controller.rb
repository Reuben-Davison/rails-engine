class Api::V1::ItemsController <ApplicationController 
    def index 
        render json: ItemSerializer.new(Item.all)
    end

    def show 
        render json: ItemSerializer.new(Item.find(params[:id])) 
    end

    def create 
        item = Item.new(item_params)
        if item.save
            render json: ItemSerializer.new(item), status: :created
        else 
           render status: 404
        end 
    end

    def update 
        item = Item.update(params[:id], item_params)
        if  item.save
            render json: ItemSerializer.new(item)
       else 
            render status: 404 
       end
    end

    def destroy 
        render json: Item.delete(params[:id])
    end

    def find_all
        if params[:name]
            render json: ItemSerializer.new(Item.find_by_name(params[:name]))
        else 
            render json: ItemSerializer.new(Item.find_by_price(params[:min_price], params[:max_price] ))
        end   
    end

    private 

    def item_params 
        params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end
end