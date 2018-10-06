ActiveAdmin.register ActiveStorage::Blob do
  menu parent: 'utils', priority: 1,
       label: I18n.t('active_admin.local.storage_blobs')

  permit_params :key, :filename, :content_type, :metadata, :byte_size, :checksum, :created_at


  actions :index

  filter :content_type
  filter :created_at

  scope :all, default: true
  scope :unattached


  index do
    id_column
    column :preview, sortable: false,
           class: 'c-preview h-width--icon' do |model|
      if model.content_type.match /^image\//
        image = model.variant resize_to_fill 96
      end
      if model.content_type.match /^(video\/|application\/pdf)/
        # image = model.preview resize_to_fill 96
      end
      image_tag (image or image_url 'system/image.svg'),
                class: 'img-thumbnail h-m_x--auto',
                width: 96,
                height: 96
    end
    column :filename
    column :content_type
    column :byte_size, class: 'h-width--10' do |model|
      '%.1f Kb' % (model.byte_size.to_f / 1024)
    end
    column :key
    column :created_at, class: 'h-width--date'
  end


  action_item :remove_trash, only: :index do
    unless ActiveStorage::Blob.unattached.empty?
      link_to I18n.t('active_admin.action_items.remove_trash', count: ActiveStorage::Blob.unattached.count),
              remove_trash_admin_active_storage_blobs_path,
              method: :patch
    end
  end

  collection_action :remove_trash, method: :patch do
    count = ActiveStorage::Blob.unattached.map(&:purge).count
    redirect_back fallback_location: admin_active_storage_blobs_path,
                  notice: I18n.t('active_admin.collection_actions.removed_trash', count: count)
  end
end
