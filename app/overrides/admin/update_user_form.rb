Deface::Override.new(virtual_path: 'spree/admin/users/_form',
 name: 'add new field into create new user',
 insert_top: "[data-hook='admin_user_form_fields']",
 text: "
 <div class='col-md-12'>
 <%= f.field_container :username, class: ['form-group'] do %>
 <%= f.label :username, 'Username' %>
 <%= f.text_field :username, :class => 'form-control' %>
 <% end %>
 <div class='form-group'>
   <%= f.check_box :account_confirmed %>
   <%= f.label :account_confirmed, 'Active this account' %>
 </div>
 </div>
 ",
 :original => '080d8280246efac668cd1be3531c8bfdfd826b30')