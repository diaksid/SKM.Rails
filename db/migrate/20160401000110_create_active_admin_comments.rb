class CreateActiveAdminComments < ActiveRecord::Migration[5.2]

  def change
    create_table :active_admin_comments do |t|
      t.string :namespace, index: true
      t.text   :body

      t.references :resource, polymorphic: true
      t.references :author, polymorphic: true

      t.timestamps
    end
  end

end
