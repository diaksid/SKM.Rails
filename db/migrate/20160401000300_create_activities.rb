class CreateActivities < ActiveRecord::Migration[5.2]

  def change
    create_table :activities do |t|
      t.boolean :published, :navigated, default: false, index: true

      t.string :name, null: false, index: {unique: true}
      t.string :header
      t.text :content
      t.boolean :partial, default: false

      t.string :title
      t.string :keywords
      t.string :description
      t.string :canonical
      t.string :robots

      t.integer :index, default: 0, index: true

      t.timestamps
    end
  end

end
