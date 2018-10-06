class AreasThrough < ApplicationRecord

  belongs_to :resource, polymorphic: true
  belongs_to :area

  validates_presence_of :resource_type, :resource_id, :area_id
  validates_uniqueness_of :area_id,
                          scope: [:resource_type, :resource_id]

end
