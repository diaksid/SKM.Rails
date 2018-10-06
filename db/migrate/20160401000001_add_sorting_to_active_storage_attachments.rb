class AddSortingToActiveStorageAttachments < ActiveRecord::Migration[5.2]
  def change
    change_table :active_storage_attachments do |t|
      t.integer :index, default: 0
      t.index [ :record_type, :record_id, :index ], name: "index_active_storage_attachments_sorting"
    end
  end
end
