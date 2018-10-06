ActiveAdmin.register Customer do
  include AdminActive
  include AdminWebPage

  menu priority: 3

  permit_params :active, :published, :navigated,
                :name, :content,
                :email, :phone, :address, :geo, :website,
                :title, :keywords, :description, :canonical, :robots,
                :index,
                :attach, :attach_purge,
                :user_id,
                targets_attributes: [:id, :index,
                                     :name, :published, :importance]

  includes :targets


  scope :all, default: true
  scope :unscoped

  filter :name
  filter :published
  filter :navigated
  filter :created_at

  sortable tree: false,
           sorting_attribute: :index
  # config.paginate = true

  index do
    selectable_column
    id_column
    column_aimg :attach, class: 'h-width--icon'
=begin
    column :upload, class: 'h-width--icon', sortable: false do |model|
      link_to edit_admin_customer_path(model) do
        imagic_tag model.upload.icon,
                   class: 'c-img--thumbnail h-margin-x--auto',
                    width: 96,
                    height: 96
      end
    end
=end
    column :active, class: 'h-width--bool'
    column :published, class: 'h-width--bool'
    column :name
    column :email, class: 'h-width--20'
    column :phone, class: 'h-width--10'
    column :created_at
    column :index, class: 'h-width--int'
    actions
  end

  index as: :sortable do
    label :name do |model|
      html = '%03i %s %s %s <span>%03i</span>' % [
        model.index,
        (model.active ? '<i>активно</i>' : '<em>не активно</em>'),
        (model.published ? '<i>опубликовано</i>' : '<em>не опубликовано</em>'),
        (model.navigated ? '<i>в навигации</i>' : '<em>вне навигации</em>'),
        model.id
      ]
      html = "%s <small>%s</small>" % [model.name, html]
      html.html_safe
    end
    actions
  end


  show do
    attributes_table do
      row_html :content, class: 'h-text--readable'
      row :email
      row :phone
      row :address
      row :geo
      row :website
    end
    panel I18n.t('active_admin.local.targets', count: resource.targets.count) do
      table_for resource.targets do
        column :index, class: 'h-width--int'
        column_aimg :attach, class: 'h-width--icon'
        column :name
        column :created_at, class: 'h-width--date'
        column :id, class: 'h-width--int'
=begin
        column :cover, class: 'h-width--icon' do |model|
          imagic_tag model.cover && model.cover.icon
        end
=end
      end
    end unless resource.targets.empty?
    panel I18n.t('active_admin.panels.seo') do
      render partial: 'admin/show/seo'
    end
    active_admin_comments
  end


  form do |f|
    f.semantic_errors *f.object.errors.keys
    tabs do
      tab I18n.t('active_admin.panels.data') do
        f.inputs do
          f.input :active, as: :select, include_blank: false,
                  input_html: {class: 'c-control-select'}
          f.input :published, as: :select, include_blank: false,
                  input_html: {class: 'c-control-select'}
          f.input :navigated, as: :select, include_blank: false,
                  input_html: {class: 'c-control-select'}
          # f.input :index, as: :number,
          #         input_html: {class: 'h-width--10',
          #                      min: 0}
        end
        f.inputs do
          f.input :name,
                  input_html: {class: 'h-width--40'}
          f.input :content, as: :redactor
        end
        f.inputs do
          f.input :attach, as: :file,
                  input_html: {multiple: false, accept: 'image/*'}
          f.input :attach_purge, as: :boolean,
                  input_html: {disabled: !resource.attach.attached?}
        end unless f.object.new_record?
=begin
        f.inputs do
          f.input :upload, as: :file,
                  input_html: {accept: f.object.upload.input_accept}
        end
=end
      end
      tab I18n.t('active_admin.local.contacts') do
        f.inputs do
          f.input :phone, as: :phone,
                  input_html: {class: 'h-width--40'}
          f.input :email, as: :email,
                  input_html: {class: 'h-width--40'}
          f.input :address
          f.input :geo,
                  input_html: {class: 'h-width--20'}
          f.input :website,
                  input_html: {class: 'h-width--20'}
          f.input :user, as: :select, include_blank: true,
                  collection: User.all.collect { |u| [u.to_s, u.id] },
                  input_html: {class: 'c-control-select h-width--30'}
        end
      end
      tab I18n.t('active_admin.local.targets', count: f.object.targets.count) do
        f.inputs do
          f.has_many :targets, heading: false, class: 'has-upload_icon',
                     sortable: 'index', allow_destroy: false, new_record: false do |n|
            n.input :attach, as: :attached_icon,
                    wrapper_html: {class: 'handle'}
            n.input :name,
                    input_html: {disabled: true}
            n.input :published, as: :select, include_blank: false,
                    input_html: {class: 'c-control-select'}
            n.input :navigated, as: :select, include_blank: false,
                    input_html: {class: 'c-control-select'}
            n.input :importance, as: :select, include_blank: false,
                    collection: Target::IMPORTANTS.to_a,
                    input_html: {class: 'c-control-select'}
=begin
            n.input :cover, as: :upload_icon,
                    wrapper_html: {class: 'handle'}
=end
          end
        end
      end unless f.object.targets.empty?
      tab I18n.t('active_admin.panels.seo') do
        render partial: 'admin/form/seo', locals: {form: f}
      end
    end
    f.actions
  end


  sidebar I18n.t('activerecord.attributes.customer.attach'),
          priority: 0, only: [:show, :edit, :update] do
    render partial: 'admin/image', object: resource.attach, locals: {size: 192}
  end

  sidebar I18n.t('active_admin.sidebars.relations'),
          priority: 1, only: [:show, :edit, :update] do
    attributes_table do
      row :targets do |model|
        link_to model.targets.count, admin_targets_path('q[customer_id_eq]' => model)
      end
      row :feedbacks do |model|
        link_to model.feedbacks.count, admin_feedbacks_path('q[customer_id_eq]' => model)
      end
    end
  end

  sidebar I18n.t('active_admin.sidebars.state'),
          priority: 2, only: [:show, :edit, :update] do
    attributes_table_for resource do
      row :active
      row :published
      row :navigated
      row :index
      row :id
      row :updated_at
      row :created_at
    end
  end


  controller do
    def update
      attach = params[:customer].include?(:attach) ? params[:customer].delete('attach') : false
      super do |format|
        if resource.valid?
          if params[:customer][:attach_purge] == '1'
            resource.attach.purge
          end
          if attach
            resource.attach.attach attach
          end
        end
      end
    end
  end

=begin
  action_item :upload_recreate_versions, only: :index do
    link_to 'Перемонтировать изображения',
            upload_recreate_versions_admin_customers_path,
            method: :patch
  end

  action_item :upload_recreate_versions, only: :show do
    link_to 'Перемонтировать изображения',
            upload_recreate_versions_admin_customers_path(id: resource),
            method: :patch
  end


  collection_action :upload_recreate_versions, method: :patch do
    if permitted_params[:id].blank?
      done = Customer.upload_recreate_versions
      redirect_back fallback_location: admin_dashboard_path, notice: "[#{done}] Изображения коллекции перемонтированы!"
    else
      done = Customer.find(permitted_params[:id]).upload_recreate_versions
      redirect_back fallback_location: admin_dashboard_path, notice: "[#{done}] Изображения модели перемонтированы!"
    end
  end
=end
end
