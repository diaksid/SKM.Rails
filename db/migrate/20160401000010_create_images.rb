class CreateImages < ActiveRecord::Migration[5.2]

  def change
    create_table :images do |t|
      t.string :title
      t.string :description
      t.string :alt

      t.string :upload, null: false
      t.boolean :upload_crop, default: false

      t.integer :index, default: 0, index: true

      t.references :resource, polymorphic: true

      t.timestamps
    end
  end

end
