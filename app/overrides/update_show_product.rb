Deface::Override.new(virtual_path: 'spree/products/_cart_form',
  name: 'add new field into user registration',
  replace: "[itemprop='price']",
  partial: "spree/shared/cart_form_product")
