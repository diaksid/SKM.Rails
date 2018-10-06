ActiveAdmin.register ActiveStorage::Attachment do
  menu parent: 'utils', priority: 0,
       label: I18n.t('active_admin.local.storage_attachments')

  permit_params :name, :record, :blob, :created_at,
                :index


  actions :index

  filter :record_type,
         input_html: {class: 'control-select'}
  filter :record_id
  filter :created_at

  batch_action :purge, priority: 0 do |id|
    batch_action_collection.find(id).each do |model|
      model.purge
    end
    redirect_to collection_path, alert: t('active_admin.batch_actions.alerts.purge')
  end


  index do
    selectable_column
    id_column
    column :index, class: 'h-width--int'
    column :preview, sortable: false,
           class: 'c-preview h-width--icon' do |model|
      if model.image?
        image = model.variant resize_to_fill 96
      end
      if model.video?
        # image = model.preview resize_to_fill 96
      end
      image_tag (image or image_url 'system/image.svg'),
                class: 'img-thumbnail h-m_x--auto',
                width: 96,
                height: 96
    end
    column :content_type,
           class: 'h-width--10' do |model|
      model.content_type.blank? and '?' or model.content_type
    end
    column :name
    column :record
    column :created_at, class: 'h-width--date'
    actions defaults: false do |model|
      item I18n.t('active_admin.local.up'),
           up_admin_active_storage_attachment_path(model),
           class: 'member_link', method: :patch, data: {confirm: I18n.t('active_admin.default_confirmation')}
      item I18n.t('active_admin.local.down'),
           down_admin_active_storage_attachment_path(model),
           class: 'member_link', method: :patch, data: {confirm: I18n.t('active_admin.default_confirmation')}
      item I18n.t('active_admin.delete'),
           purge_admin_active_storage_attachment_path(model),
           class: 'member_link', method: :delete, data: {confirm: I18n.t('active_admin.delete_confirmation')}
    end
  end


  member_action :up, method: :patch do
    model = ActiveStorage::Attachment.find(permitted_params[:id])
    model.update index: (model.index - 1) if model.index > 0
    redirect_back fallback_location: admin_active_storage_attachments_path,
                  notice: "#{model.id} UP!"
  end

  member_action :down, method: :patch do
    model = ActiveStorage::Attachment.find(permitted_params[:id])
    model.update index: (model.index + 1)
    redirect_back fallback_location: admin_active_storage_attachments_path,
                  notice: "#{model.id} DOWN!"
  end

  member_action :purge, method: :delete do
    model = ActiveStorage::Attachment.find(permitted_params[:id])
    model.purge
    redirect_back fallback_location: admin_active_storage_attachments_path,
                  notice: "#{model.id} PURGED!"
  end


  action_item :remove_trash, only: :index do
    if (count = ActiveStorage::Attachment.all.select {|m| m.record == nil}.count) > 0
      link_to I18n.t('active_admin.action_items.remove_trash',
                     count: count),
              remove_trash_admin_active_storage_attachments_path,
              method: :patch
    end
  end

  collection_action :remove_trash, method: :patch do
    count = ActiveStorage::Attachment.all.select {|m| m.record == nil}.map(&:purge).count
    redirect_back fallback_location: admin_active_storage_blobs_path,
                  notice: I18n.t('active_admin.collection_actions.removed_trash',
                                 count: count)
  end
end
