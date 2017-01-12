Deface::Override.new(virtual_path: 'spree/users/show',
  name: 'add new field into user registration',
  replace: "dl#user-info",
  text: "
  <dt><%= 'User Name' %></dt>
  <dd><%= @user.username %> (<%= link_to Spree.t(:edit), spree.edit_account_path %>)</dd>
  <dt><%= 'Email' %></dt>
  <dd><%= @user.email %> </dd>
  ")
