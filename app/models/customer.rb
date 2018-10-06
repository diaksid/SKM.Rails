class Customer < ApplicationRecord
  include WebPage
  include HasAttachment
  # include HasUpload

  # mount_uploader :upload, CustomerUploader

  has_many :targets
  accepts_nested_attributes_for :targets,
                                allow_destroy: false
  has_many :feedbacks
  accepts_nested_attributes_for :feedbacks,
                                allow_destroy: false

  belongs_to :user,
             optional: true

  acts_as_list column: :index,
               top_of_list: 0


  validates_presence_of :name
  validates_uniqueness_of :name,
                          case_sensitive: false


  default_scope { order(:index, :name) }
  scope :active, -> {where(active: true)}

  paginates_per 2


  def header
    name
  end
end
