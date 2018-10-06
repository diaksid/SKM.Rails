class Feedback < ApplicationRecord
  include WebPage
  include HasUpload

  mount_uploader :upload, FeedbackUploader

  belongs_to :customer


  validates_presence_of :header, :upload


  default_scope { order(published: :desc, published_at: :desc, header: :asc) }
  scope :recent, -> (num) { order(published_at: :desc, header: :asc).limit(num) }

  paginates_per 2


  def to_s
    "#{I18n.t 'activerecord.models.feedback.one'} ##{id}"
  end


  def name
    to_s
  end


  private


  def check_attributes
    self.published_at = DateTime.now if self.published && self.published_at.blank?
  end
end
