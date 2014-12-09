ActiveAdmin.register Project do
  filter :name
  
  # Views
  index do |row|
    column(:project){|p| "#{p.username}/#{p.name}"}
    actions
  end

  show :title => :username do
    attributes_table do
      row :username
      row :name
      row :description
    end
  end

  form do |f|
    f.inputs do
      f.input :username
      f.input :name
      f.input :description
      f.actions
    end
  end
  permit_params :username, :name, :description
end
