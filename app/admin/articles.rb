ActiveAdmin.register Article do

  permit_params :title, :content, :category_id

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do
      f.input :category
      f.input :title
      f.input :content, as: :action_text
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end
  
  # permit_params do
  #   permitted = [:title, :content, :category_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
