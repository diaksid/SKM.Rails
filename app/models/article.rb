class Article < ApplicationRecord
  include WebPage
  include HasUpload

  mount_uploader :upload, ArticleUploader


  validates_presence_of :header
  validates_uniqueness_of :header,
                          scope: :published_at

  before_save :check_attributes


  default_scope { order(published: :desc, published_at: :desc, header: :asc) }
  scope :recent, -> (num) { order(published_at: :desc, header: :asc).limit(num) }

  paginates_per 2


  def to_s
    "#{I18n.t 'activerecord.models.article.one'} ##{id}"
  end


  def name
    to_s
  end


  private


  def check_attributes
    self.published_at = DateTime.now if self.published && self.published_at.blank?
  end
end
