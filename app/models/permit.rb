class Permit < ApplicationRecord
  include WebPage
  include HasAttachments
  # include HasImages

  validates_presence_of :name, :number, :provider, :issue_at
  validates_uniqueness_of :number,
                          case_sensitive: false


  default_scope { order(:index, :name) }

  paginates_per 2


  def active?
    end_at.nil? || end_at >= Date.today
  end
end
