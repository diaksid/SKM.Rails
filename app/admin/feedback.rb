ActiveAdmin.register Feedback do
  include AdminWebPage

  menu priority: 6

  permit_params :published, :published_at,
                :header, :content,
                :upload,
                :title, :keywords, :description, :canonical, :robots,
                :source,
                :customer_id,
                :attaches_purge, attaches: [], attaches_attachments_attributes: [:id, :index, :_destroy]

  includes :customer, :attaches_attachments


  scope :all, default: true
  scope :unscoped

  filter :header
  filter :published
  filter :published_at
  filter :navigated
  filter :source
  filter :customer,
         input_html: {class: 'c-control-select'},
         unless: proc { Customer.all.empty? }
  filter :created_at

  index do
    selectable_column
    id_column
    column :published, class: 'h-width--boolean'
    column :published_at, class: 'h-width--date'
    column :upload, class: 'h-width--icon', sortable: false do |model|
      link_to admin_article_path(model) do
        imagic_tag model.upload.icon,
                   class: 'c-img--thumbnail h-block h-margin-x--auto',
                   width: 96,
                   height: 96
      end
    end
    column :header
    column :source, class: 'h-width--20'
    column :created_at
    actions
  end


  show do
    attributes_table do
      row :header
      row :content do |model|
        div class: 'с-text--readable' do
          model.content.html_safe
        end unless model.content.blank?
      end
      row :source
      row :customer
    end
    panel 'SEO' do
      attributes_table_for resource do
        row :title
        row :keywords
        row :description
      end
      attributes_table_for resource do
        row :canonical
        row :robots
      end
    end
    active_admin_comments
  end


  form do |f|
    f.semantic_errors *f.object.errors.keys
    tabs do
      tab 'Данные' do
        f.inputs do
          f.input :published, as: :select, include_blank: false,
                  input_html: {class: 'c-control-select'}
          f.input :published_at, as: :date_picker
        end
        f.inputs do
          f.input :upload, as: :file,
                  input_html: {accept: f.object.upload.input_accept}
        end
        f.inputs do
          f.input :source
          f.input :customer, as: :select, include_hidden: true,
                  collection: Customer.all.collect { |model| [model.name, model.id] },
                  input_html: {class: 'c-control-select h-width--50'} unless Customer.all.empty?
        end
        f.inputs do
          f.input :header
          f.input :content,
                  input_html: {class: 'h-js--redactor',
                               rows: 7}
        end
      end
      tab 'SEO' do
        f.inputs do
          f.input :title
          f.input :keywords
          f.input :description
        end
        f.inputs do
          f.input :canonical
          f.input :robots, as: :select, include_blank: true,
                  collection: Webpage::ROBOTS.to_a,
                  input_html: {class: 'c-control-select'}
        end
      end
    end
    f.actions
  end


  sidebar 'Публикация', only: :show do
    attributes_table_for resource do
      row :published
      row :published_at
    end
  end

  sidebar 'Скан', only: [:show, :edit] do
    imagic_tag resource.upload.thumb,
               class: 'c-img--response h-display--block h-margin-x--auto',
               width: 320,
               height: 454
  end

  sidebar 'Статистика', only: [:show, :edit] do
    attributes_table do
      row :updated_at
      row :created_at
    end
  end


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
      done = Feedback.upload_recreate_versions
      redirect_back fallback_location: admin_dashboard_path, notice: "[#{done}] Изображения коллекции перемонтированы!"
    else
      done = Feedback.find(permitted_params[:id]).upload_recreate_versions
      redirect_back fallback_location: admin_dashboard_path, notice: "[#{done}] Изображения модели перемонтированы!"
    end
  end

end
