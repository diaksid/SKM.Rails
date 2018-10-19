ActiveAdmin.register Target do
  include AdminWebPage

  menu priority: 4

  permit_params :published, :navigated,
                :importance, :start_at, :finish_at,
                :name, :content,
                :address, :geo, :website,
                :title, :keywords, :description, :canonical, :robots,
                :index,
                :customer_id,
                :attaches_purge, attaches: [], attaches_attachments_attributes: [:id, :index, :_destroy],
                area_ids: []
=begin
                images_attributes: [:id, :index,
                                    :title, :description, :alt,
                                    :upload, :upload_crop,
                                    :_destroy]
=end

  includes :customer, :areas, :attaches_attachments # :images


  scope :all, default: true
  scope :individual
  scope :unscoped

  filter :name
  filter :published
  filter :navigated
  filter :importance, as: :select, collection: Target::IMPORTANTS.to_a,
         input_html: {class: 'c-control-select'}
  filter :areas,
         input_html: {class: 'c-control-select'},
         unless: proc { Area.all.empty? }
  filter :customer,
         input_html: {class: 'c-control-select'},
         unless: proc { Customer.all.empty? }
  filter :created_at

  sortable tree: false,
           sorting_attribute: :index
  # config.paginate = true

  index do
    selectable_column
    id_column
    column_aimg :attach, class: 'h-width--icon'
=begin
    column :cover, class: 'h-width--icon', sortable: false do |model|
      link_to edit_admin_target_path(model) do
        imagic_tag model.cover,
                   class: 'c-img--thumbnail h-margin-x--auto',
                   width: 96,
                   height: 96
      end
    end
=end
    column :published, class: 'h-width--bool'
    column :navigated, class: 'h-size--bool'
    column :importance, class: 'h-width--10' do |model|
      Target::IMPORTANTS.key model.importance
    end
    column :name
    column :areas, class: 'h-width--20' do |model|
      model.areas_show '<br>'
    end
    column :customer
    column :index, class: 'h-size--int'
    actions
  end

  index as: :table_alter do
    selectable_column
    id_column
    column_aimg :attach, class: 'h-width--icon'
    column :published, class: 'h-width--bool'
    column :navigated, class: 'h-size--bool'
    column :importance, class: 'h-width--int'
    column :name
    column :start_at, class: 'h-width--date'
    column :finish_at, class: 'h-width--date'
    column :created_at, class: 'h-width--datetime'
    column :index, class: 'h-width--int'
    actions
  end

  index as: :sortable do
    label :name do |model|
      html = '%03i %s %s <i>[ %s ]</i> <span>%03i <i>%s</i></span>' % [
        model.index,
        (model.published ? '<i>опубликовано</i>' : '<em>не опубликовано</em>'),
        (model.navigated ? '<i>в навигации</i>' : '<em>вне навигации</em>'),
        (model.areas.empty? ? '--' : model.areas_show),
        model.id,
        (model.customer.nil? ? '--' : model.customer.name)
      ]
      html = "%s <small>%s</small>" % [model.name, html]
      html.html_safe
    end
    actions
  end


  show do
    attributes_table do
      row :importance do |model|
        Target::IMPORTANTS.key model.importance
      end
      row :customer
      row_html :content, class: 'h-text--readable'
      row :address
      row :geo
      row :website
    end
    panel I18n.t('active_admin.panels.activity') do
      attributes_table_for resource do
        row :areas do |model|
          model.areas_show '<br>'
        end
        row :start_at
        row :finish_at
      end
    end
    panel I18n.t('active_admin.panels.images', count: resource.attaches.count) do
      render partial: 'admin/show/images'
    end unless resource.attaches.empty?
    panel I18n.t('active_admin.panels.seo') do
      render partial: 'admin/show/seo'
    end
=begin
    panel 'Изображения' do
      table_for resource.images do
        column :id, class: 'h-width--integer' do |model|
          if can? :update, Image
            link_to model.id, edit_admin_image_path(model)
          else
            model.id
          end
        end
        column :upload, class: 'h-width--10' do |model|
          imagic_tag model.upload.icon
        end
        column :title, class: 'h-width--40'
        column :alt
        column :upload_crop, class: 'h-width--10' do |model|
          status_tag model.upload_crop
        end
      end
    end unless resource.images.empty?
=end
    active_admin_comments
  end


  form do |f|
    f.semantic_errors *f.object.errors.keys
    tabs do
      tab I18n.t('active_admin.panels.data') do
        f.inputs do
          f.input :published, as: :select, include_blank: false,
                  input_html: {class: 'c-control-select'}
          f.input :navigated, as: :select, include_blank: false,
                  input_html: {class: 'c-control-select'}
          # f.input :index, as: :number,
          #         input_html: {class: 'h-width--int',
          #                      min: 0}
          f.input :customer, as: :select, include_hidden: true,
                  collection: Customer.all.collect { |model| [model.name, model.id] },
                  input_html: {class: 'c-control-select h-width--50'} unless Customer.all.empty?
          f.input :importance, as: :select, include_blank: false,
                  collection: Target::IMPORTANTS.to_a,
                  input_html: {class: 'c-control-select'}
        end
        f.inputs do
          f.input :name,
                  input_html: {class: 'h-width--40'}
          f.input :header
          f.input :content, as: :redactor
        end
        f.inputs do
          f.input :address
          f.input :geo,
                  input_html: {class: 'h-width--20'}
          f.input :website,
                  input_html: {class: 'h-width--20'}
        end
      end
      tab I18n.t('active_admin.panels.activity') do
        f.inputs do
          f.input :areas, as: :select, include_hidden: false, include_blank: false, multiple: true,
                  collection: Area.all.collect { |model| [model.name, model.id] },
                  input_html: {class: 'c-control-select c-control-select--full h-width--50',
                               size: Area.all.count} unless Area.all.empty?
          f.input :start_at, as: :date_picker
          f.input :finish_at, as: :date_picker
        end
      end unless f.object.new_record?
      tab I18n.t('active_admin.panels.images', count: f.object.attaches.count) do
        render partial: 'admin/form/images', locals: {form: f}
      end unless f.object.new_record?
      tab I18n.t('active_admin.panels.seo') do
        render partial: 'admin/form/seo', locals: {form: f}
      end
=begin
      tab 'Изображения' do
        f.inputs do
          f.has_many :images, heading: false, class: 'has-upload_icon',
                     sortable: 'index', allow_destroy: true, new_record: 'Добавить' do |n|
            if n.object.new_record?
              n.input :upload, as: :file,
                      input_html: {accept: n.object.upload.input_accept}
            else
              n.input :upload, as: :upload_icon,
                      wrapper_html: {class: 'handle'}
            end
            n.input :title
            n.input :alt
            n.object.upload_crop = true if n.object.new_record?
            n.input :upload_crop, as: :select, include_blank: false,
                    input_html: {class: 'c-control-select'}
          end
        end
      end unless f.object.new_record?
=end
    end
    f.actions
  end


  sidebar I18n.t('active_admin.sidebars.state'),
          priority: 0, only: [:show, :edit, :update] do
    attributes_table_for resource do
      row :published
      row :navigated
      row :index
      row :id
      row :updated_at
      row :created_at
    end
  end

  sidebar I18n.t('activerecord.attributes.target.attach'),
          priority: 1, only: [:show, :edit, :update] do
    render partial: 'admin/image', object: resource.attach,
           locals: {size: 192}
  end


  action_item :indexing, only: :index do
    link_to I18n.t('active_admin.action_items.indexing'),
            indexing_admin_targets_path,
            method: :patch
  end

  collection_action :indexing, method: :patch do
    Customer.all.each do |model|
      model.targets.order(:index).each.with_index do |item, idx|
        item.update_column :index, idx
      end
    end
    Target.individual.order(:index).each.with_index do |item, idx|
      item.update_column :index, idx
    end
    redirect_back fallback_location: admin_targets_path,
                  notice: I18n.t('active_admin.collection_actions.indexing')
  end

=begin
  action_item :images_recreate_versions, only: :index do
    link_to 'Перемонтировать изображения',
            images_recreate_versions_admin_targets_path,
            method: :patch
  end

  action_item :images_recreate_versions, only: :show do
    link_to 'Перемонтировать изображения',
            images_recreate_versions_admin_targets_path(id: resource),
            method: :patch
  end


  collection_action :images_recreate_versions, method: :patch do
    if permitted_params[:id].blank?
      done = Target.images_recreate_versions
      redirect_back fallback_location: admin_dashboard_path, notice: "[#{done}] Изображения коллекции перемонтированы!"
    else
      done = Target.find(permitted_params[:id]).images_recreate_versions
      redirect_back fallback_location: admin_dashboard_path, notice: "[#{done}] Изображения модели перемонтированы!"
    end
  end
=end


  controller do
    def create
      super do |format|
        redirect_to edit_admin_target_path(resource) and return if resource.valid?
      end
    end

    def update
      params[:target][:area_ids] = [] unless params[:target].include? :area_ids
      purge = []
      if params[:target].include? :attaches_attachments_attributes
        params[:target][:attaches_attachments_attributes].each do |idx, param|
          if param[:_destroy] == '1'
            purge << param[:id]
            param[:_destroy] = '0'
          end
        end
      end
      attaches = params[:target].include?(:attaches) ? params[:target].delete('attaches') : false
      super do |format|
        if resource.valid?
          if params[:target][:attaches_purge] == '1'
            resource.attaches.purge
          elsif !purge.empty?
            ActiveStorage::Attachment.find(purge).each(&:purge)
          end
          if attaches
            resource.attaches.attach attaches
          end
          if !resource.attaches.empty? && (!purge.empty? || attaches)
            resource.attaches.order(:index).each.with_index do |item, idx|
              item.update_column :index, idx
            end
          end
        end
      end
    end
  end
end
