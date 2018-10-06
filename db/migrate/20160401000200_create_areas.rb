class CreateAreas < ActiveRecord::Migration[5.2]

  def change
    create_table :areas do |t|
      t.boolean :active, default: false, index: true

      t.string :name, null: false, index: {unique: true}

      t.integer :index, default: 0, index: true

      t.timestamps
    end
  end

end
