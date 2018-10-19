class Activity < ApplicationRecord
  include WebPage
  include HasAreas
  include HasAttachments
  # include HasImages

  has_ancestry orphan_strategy: :rootify,
               cache_depth: true

  acts_as_list column: :index,
               top_of_list: 0


  default_scope { order(:ancestry, :index) }


  validates_presence_of :name
  validates_uniqueness_of :name,
                          case_sensitive: false

  before_save :check_attributes
  after_save :check_partial

  paginates_per 10


  def targets
    Target.joins(:areas).where(areas: {id: areas}).distinct
  end


  def select_options(ignore = nil)
    arr = []
    unless id == ignore
      arr.push ["#{'— ' * ancestry_depth } #{name}", id]
      children.each { |model| arr += model.select_options(ignore) }
    end
    arr
  end


  def self.select_options(ignore = nil)
    arr = []
    Activity.roots.each { |model| arr += model.select_options(ignore) }
    arr
  end


  private


  def check_attributes
    self.navigated = false unless published
  end


  def check_partial
    if partial
      dir = Rails.root.join 'app', 'views', model_name.plural, 'partials'
      Dir.mkdir(dir) unless Dir.exist? dir
      file = File.join dir, '_%05d.html.slim' % id
      File.open(file, 'w+') unless File.exist? file
    end
  end
end
