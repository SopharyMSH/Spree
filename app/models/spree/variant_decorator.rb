module Spree
  Variant.class_eval do
    alias_method :orig_price_in, :price_in

    def price_in(currency, args = {})
      return orig_price_in(currency) unless sale_price.present? && args[:current_user].nil?
      Spree::Price.new(variant_id: self.id, amount: self.sale_price, currency: currency)
    end
  end
end
