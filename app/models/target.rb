class Target < ApplicationRecord
  include WebPage
  include HasAreas
  include HasAttachments
  # include HasImages

  belongs_to :customer
  acts_as_list column: :index,
               top_of_list: 0,
               scope: :customer

  IMPORTANTS = {
    'Типовой': 0,
    'Важный': 1,
    'Важнейший': 2
  }

  validates_presence_of :name
  validates_uniqueness_of :name,
                          case_sensitive: false
  validates_inclusion_of :importance,
                         in: 0..3


  default_scope {order(importance: :desc, start_at: :desc, name: :asc)}
  scope :customers, -> {left_joins(:customer).merge(Customer.order(:index)).order(:index)}
  scope :individual, -> {where(customer: nil)}
  scope :important, -> { where(importance: 1..2) }
  scope :active, -> {where('finish_at >= ?', Date.today).or(where(finish_at: nil))}
  scope :inactive, -> {where('finish_at < ?', Date.today).where.not(finish_at: nil)}
  scope :weight, -> { order(importance: :desc, start_at: :asc, name: :asc) }
  scope :recent, -> (num) {order(start_at: :desc, name: :asc).limit(num)}


  paginates_per 2
end
