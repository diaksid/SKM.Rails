class AddDetailsToUsers < ActiveRecord::Migration[5.2]

  def change
    change_table :users do |t|
      t.boolean :is_admin, :in_staff, default: false
      t.index [:is_admin, :in_staff]
      t.string :name, :phone, :address
    end
  end

end
