module Spree
  LineItem.class_eval do

    def single_money(current_user)
      price = current_user.present? ? variant.price : variant.sale_price
      Spree::Money.new(price, currency: 'USD')
    end
  end
end
