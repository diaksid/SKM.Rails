class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.boolean :published, :navigated, default: false, index: true
      t.date :published_at, index: true

      t.string :header, null: false, index: true
      t.text :content

      t.string :upload

      t.string :title
      t.string :keywords
      t.string :description
      t.string :canonical
      t.string :robots

      t.string :source
      t.references :customer, foreign_key: {on_delete: :nullify}

      t.timestamps
    end
  end
end
