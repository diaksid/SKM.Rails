module HasAreas
  extend ActiveSupport::Concern

  included do
    has_many :areas_throughs, as: :resource,
             dependent: :destroy
    accepts_nested_attributes_for :areas_throughs,
                                  allow_destroy: true
    has_many :areas, through: :areas_throughs
  end


  def areas_show(separator = ', ')
    areas.collect { |model| model.name }.join(separator).html_safe
  end


  module ClassMethods
  end

end
