ActiveAdmin.register Area do
  include AdminActive

  menu priority: 1

  permit_params :active, :index, :name


  scope :all, default: true

  filter :active
  filter :name
  filter :created_at

  sortable tree: false,
           sorting_attribute: :index
  # config.paginate = true

  index do
    selectable_column
    id_column
    column :active, class: 'h-width--bool'
    column :name
    column :created_at, class: 'h-width--date'
    column :index, class: 'h-width--int'
    actions
  end

  index as: :sortable do
    label :name do |model|
      html = "%03i %s <span>%03i</span>" % [
        model.index,
        (model.active ? '<i>активно</i>' : '<em>не активно</em>'),
        model.id
      ]
      html = "%s <small>%s</small>" % [model.name, html]
      html.html_safe
    end
    actions
  end


  show title: :name do
    attributes_table do
      row :active
      row :index
    end
    active_admin_comments
  end


  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :active, as: :select, include_blank: false,
              input_html: {class: 'c-control-select'}
      # f.input :index, as: :number,
      #         input_html: {class: 'h-width--int',
      #                      min: 0}
      f.input :name,
              input_html: {class: 'h-width--40'}
    end
    f.actions
  end


  sidebar I18n.t('active_admin.sidebars.relations'),
          priority: 0, only: [:show, :edit, :update] do
    attributes_table do
      row :activities do |model|
        link_to model.activities.count,
                admin_activities_path('q[areas_throughs_area_id_eq]': model)
      end
      row :targets do |model|
        link_to model.targets.count,
                admin_targets_path('q[areas_throughs_area_id_eq]': model)
      end
    end
  end
end
