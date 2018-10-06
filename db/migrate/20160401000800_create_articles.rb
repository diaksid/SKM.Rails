class CreateArticles < ActiveRecord::Migration[5.2]

  def change
    create_table :articles do |t|
      t.boolean :published, :navigated, default: false, index: true
      t.date :published_at, index: true

      t.string :header, null: false, index: true
      t.text :annotation
      t.text :content
      t.boolean :partial, default: false

      t.string :upload
      t.boolean :upload_crop, default: true

      t.string :title
      t.string :keywords
      t.string :description
      t.string :canonical
      t.string :robots

      t.index [:published_at, :header], unique: true

      t.timestamps
    end
  end

end
