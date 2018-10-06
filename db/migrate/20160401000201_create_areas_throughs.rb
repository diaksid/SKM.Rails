class CreateAreasThroughs < ActiveRecord::Migration[5.2]

  def change
    create_table :areas_throughs do |t|
      t.references :resource, polymorphic: true
      t.references :area, foreign_key: {on_delete: :cascade}
      t.index [:resource_type, :resource_id, :area_id], unique: true,
              name: 'index_areas_throughs_for_uniqueness'
    end
  end

end
