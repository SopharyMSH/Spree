module Spree
 module Admin
   class SalePriceModelsController < ResourceController

     before_action :load_sale_prices, only: [:new, :edit]
     respond_to :json, only: [:get_children]

     def get_children
       @sale_prices = salePrice.find(params[:parent_id]).children
     end

     private

     def location_after_save
       if @sale_price_model.created_at == @sale_price_model.updated_at
         edit_admin_sale_price_model_url(@sale_price_model)
       else
         admin_sale_price_models_url
       end
     end

     def load_sale_prices
       @sale_price_model.sale_prices.build if @sale_price_model.sale_prices.empty?
     end
   end
 end
end