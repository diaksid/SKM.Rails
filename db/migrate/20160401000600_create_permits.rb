class CreatePermits < ActiveRecord::Migration[5.2]

  def change
    create_table :permits do |t|
      t.boolean :published, :navigated, default: false, index: true

      t.string :name, null: false, index: true
      t.string  :header
      t.string :number, null: false, index: {unique: true}
      t.string :provider, null: false, index: true
      t.date :issue_at, null: false, index: true
      t.date :onset_at
      t.date :end_at

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
