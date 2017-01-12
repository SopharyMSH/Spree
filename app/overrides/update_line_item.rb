Deface::Override.new(virtual_path: 'spree/orders/_line_item',
  name: 'add new field into user registration',
  replace: "[data-hook='cart_item_price']",
  partial: "spree/shared/line_item")
