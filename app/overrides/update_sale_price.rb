Deface::Override.new(virtual_path: 'spree/shared/_products',
  name: 'add new field into user registration',
  replace: "[itemprop='price']",
  partial: "spree/shared/products_for_sale")
