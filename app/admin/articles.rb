ActiveAdmin.register Article do

  permit_params :title, :content, :category_id

  # form do |f|
  #   f.inputs 'Article' do
  #     f.input :title
  #     f.rich_text_area :content
  #   end
  #   f.actions
  # end
  
  # permit_params do
  #   permitted = [:title, :content, :category_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
