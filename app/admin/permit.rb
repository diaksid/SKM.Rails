ActiveAdmin.register Permit do
  include AdminWebPage

  menu priority: 5

  permit_params :published, :navigated,
                :name, :number, :provider, :issue_at, :onset_at, :end_at,
                :title, :keywords, :description, :canonical, :robots,
                :index,
                :attaches_purge, attaches: [], attaches_attachments_attributes: [:id, :index, :_destroy]
=begin
                images_attributes: [:id, :index,
                                    :title, :description, :alt,
                                    :upload, :upload_crop,
                                    :_destroy]
=end

  includes :attaches_attachments # :images


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
    column_aimg :attach, class: 'h-width--icon', fit: true
    column :active?, class: 'h-width--bool'
    column :published, class: 'h-width--bool'
    column :navigated, class: 'h-size--bool'
    column :name
    column :number, class: 'h-width--20'
    column :provider, class: 'h-width--20'
    column :issue_at, class: 'h-width--date'
    column :index, class: 'h-width--int'
    actions
  end

  index as: :table_alter do
    selectable_column
    id_column
    column :published, class: 'h-width--boolean'
    column :navigated, class: 'h-size--bool'
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
    column :name, class: 'h-width--20'
    column :number
    column :issue_at, class: 'h-width--date'
    column :onset_at, class: 'h-width--date'
    column :end_at, class: 'h-width--date'
    column :created_at, class: 'h-width--datetime'
    column :index, class: 'h-width--integer'
    actions
  end

  index as: :sortable do
    label :name do |model|
      html = '%03i %s %s <span>%03i <i>%s</i></span>' % [
        model.index,
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
      row :name
      row :number
      row :provider
      row :issue_at
      row :onset_at
      row :end_at
    end
    panel I18n.t('active_admin.panels.images', count: resource.attaches.count) do
      render partial: 'admin/show/images',
             locals: {fit: true}
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
      tab 'Данные' do
        f.inputs do
          f.input :published, as: :select, include_blank: false,
                  input_html: {class: 'c-control-select'}
          f.input :navigated, as: :select, include_blank: false,
                  input_html: {class: 'c-control-select'}
          # f.input :index, as: :number,
          #         input_html: {class: 'h-width--10',
          #                      min: 0}
        end
        f.inputs do
          f.input :name
          f.input :number,
                  input_html: {class: 'h-width--30'}
          f.input :provider,
                  input_html: {class: 'h-width--50'}
        end
        f.inputs do
          f.input :issue_at, as: :date_picker
          f.input :onset_at, as: :date_picker
          f.input :end_at, as: :date_picker
        end
      end
      tab I18n.t('active_admin.panels.images', count: f.object.attaches.count) do
        render partial: 'admin/form/images',
               locals: {form: f,
                        fit: true}
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
           locals: {size: 192,
                    fit: true}
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
      done = Permit.images_recreate_versions
      redirect_back fallback_location: admin_dashboard_path, notice: "[#{done}] Изображения коллекции перемонтированы!"
    else
      done = Permit.find(permitted_params[:id]).images_recreate_versions
      redirect_back fallback_location: admin_dashboard_path, notice: "[#{done}] Изображения модели перемонтированы!"
    end
  end
=end


  controller do
=begin
    def create
      super do |format|
        redirect_to edit_admin_permit_path(resource) and return if resource.valid?
      end
    end
=end


    def update
      purge = []
      if params[:permit].include? :attaches_attachments_attributes
        params[:permit][:attaches_attachments_attributes].each do |idx, param|
          if param[:_destroy] == '1'
            purge << param[:id]
            param[:_destroy] = '0'
          end
        end
      end
      attaches = params[:permit].include?(:attaches) ? params[:permit].delete('attaches') : false
      super do |format|
        if resource.valid?
          if params[:permit][:attaches_purge] == '1'
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
