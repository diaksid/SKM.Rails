class Image < ApplicationRecord
  include HasUpload

  mount_uploader :upload, ImageUploader

  belongs_to :resource, polymorphic: true


  default_scope { order(:resource_type, :resource_id, :index, :title) }


  validates_presence_of :upload


  def to_s
    "#{I18n.t 'activerecord.models.image'} ##{id}"
  end


  def name
    title.blank? ? "#{I18n.t 'activerecord.models.image'} ##{id}" : title
  end
end
