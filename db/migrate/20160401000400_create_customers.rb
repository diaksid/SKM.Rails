class CreateCustomers < ActiveRecord::Migration[5.2]

  def change
    create_table :customers do |t|
      t.boolean :active, default: false, index: true
      t.boolean :published, :navigated, default: false, index: true

      t.string :name, null: false, index: {unique: true}
      t.text :content

      t.string :email
      t.string :phone
      t.string :address
      t.string :geo
      t.string :website

      t.string :upload

      t.string :title
      t.string :keywords
      t.string :description
      t.string :canonical
      t.string :robots

      t.integer :index, default: 0, index: true

      t.references :user, foreign_key: {on_delete: :nullify}

      t.timestamps
    end
  end

end
