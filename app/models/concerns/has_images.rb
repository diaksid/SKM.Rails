module HasImages
  extend ActiveSupport::Concern

  included do
    has_many :images, as: :resource,
             dependent: :destroy
    accepts_nested_attributes_for :images,
                                  allow_destroy: true
  end


  def cover
    images[0].upload unless images.empty?
  end


  def images_recreate_versions
    done = 0
    images.all.each { |model| done += model.upload_recreate_versions }
    done
  end


  module ClassMethods

    def images_recreate_versions
      done = 0
      self.all.each { |model| done += model.images_recreate_versions }
      done
    end

  end

end
