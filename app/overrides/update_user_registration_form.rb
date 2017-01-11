Deface::Override.new(
  virtual_path: 'spree/user_registrations/new',
  name: 'test',
  replace: 'fields#password-credentials',
  partial: 'spree/user_registrations/new'
  )