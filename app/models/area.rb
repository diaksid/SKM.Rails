class Area < ApplicationRecord
  has_many :areas_throughs, dependent: :destroy
  accepts_nested_attributes_for :areas_throughs,
                                allow_destroy: true

  has_many :activities, through: :areas_throughs,
           source: :resource, source_type: 'Activity'
  has_many :targets, through: :areas_throughs,
           source: :resource, source_type: 'Target'

  acts_as_list column: :index,
               top_of_list: 0

  default_scope {order(active: :desc, index: :asc, name: :asc)}
  scope :active, -> { where(active: true) }

  validates_presence_of :name
  validates_uniqueness_of :name,
                          case_sensitive: false


  def self.collect
    self.all.collect { |model| [model.name, model.id] }
  end
end
