ActiveAdmin.register User do
  menu priority: 9 # , parent: 'utils'

  permit_params :email, :password, :password_confirmation,
                :is_admin, :in_staff, :name, :phone, :address,
                :attach, :attach_purge


  scope :all, default: true
  scope :admin
  scope :staff
  scope :client

  filter :name
  filter :email
  filter :current_sign_in_at
  filter :created_at

  index default: true do
    selectable_column
    id_column
    column_aimg :attach, class: 'h-width--icon'
    column :is_admin, class: 'h-width--bool'
    column :in_staff, class: 'h-width--bool'
    column :email
    column :name, class: 'h-width--10'
    column :current_sign_in_at, class: 'h-width--datetime'
    column :sign_in_count, class: 'h-width--int'
    # column :created_at
    actions
  end

  index as: :table_alter do
    selectable_column
    id_column
    column :email
    column :updated_at, class: 'h-width--datetime'
    column :created_at, class: 'h-width--datetime'
    actions
  end


  show do
    panel 'Авторизация' do
      attributes_table_for resource do
        row :email
        row :encrypted_password
        row :is_admin
        row :in_staff
      end
    end
    panel 'Профиль' do
      attributes_table_for resource do
        row :name
        row :phone
        row :address
      end
    end
    active_admin_comments
  end


  form do |f|
    f.semantic_errors
    f.inputs 'Авторизация' do
      f.input :email, as: :email,
              input_html: {class: 'h-width--20'}
      f.input :password,
              input_html: {class: 'h-width--20'}
      f.input :password_confirmation,
              input_html: {class: 'h-width--20'}
      f.input :is_admin,
              input_html: {disabled: !current_user.admin?}
      f.input :in_staff,
              input_html: {disabled: !current_user.admin?}
    end
    f.inputs 'Профиль' do
      f.input :name,
              input_html: {class: 'h-width--40'}
      f.input :phone, as: :phone,
              input_html: {class: 'h-width--40'}
      f.input :address
    end
    f.inputs do
      f.input :attach, as: :file,
              input_html: {multiple: false, accept: 'image/*'}
      f.input :attach_purge, as: :boolean,
              input_html: {disabled: !resource.attach.attached?}
    end unless f.object.new_record?
    f.actions
  end


  sidebar I18n.t('activerecord.attributes.user.attach'),
          priority: 0, only: [:show, :edit, :update] do
    render partial: 'admin/image', object: resource.attach, locals: {size: 192}
  end

  sidebar I18n.t('active_admin.sidebars.relations'),
          priority: 1, only: [:show, :edit, :update] do
    attributes_table do
      row :customers do |model|
        link_to model.customers.count, admin_customers_path('q[user_id_eq]': model)
      end
    end
  end

  sidebar I18n.t('active_admin.sidebars.state'),
          priority: 2, only: [:show, :edit, :update] do
    attributes_table do
      row :id
      row :updated_at
      row :created_at
      row :sign_in_count
      row :current_sign_in_at do |model|
        model.current_sign_in_at.blank? ? '--' : time_ago_in_words(model.current_sign_in_at)
      end
      row :current_sign_in_ip
      row :last_sign_in_at
      row :last_sign_in_ip
    end
  end


  controller do
    def update
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete('password')
        params[:user].delete('password_confirmation')
      end
      attach = params[:user].include?(:attach) ? params[:user].delete('attach') : false
      super do |format|
        if resource.valid?
          if params[:user][:attach_purge] == '1'
            resource.attach.purge
          end
          if attach
            resource.attach.attach attach
          end
        end
      end
    end
  end
end
