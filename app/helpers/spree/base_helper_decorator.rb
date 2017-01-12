Spree::BaseHelper.module_eval do
  def display_price(product_or_variant, args = {})
    product_or_variant.
    price_in(current_currency, current_user: args[:current_user]).
    display_price_including_vat_for(current_price_options).
    to_html
  end
end
