module WebPage
  extend ActiveSupport::Concern

  included do
    scope :published, -> {where(published: true)}
    scope :navigated, -> {where(published: true, navigated: true)}
  end


  ROBOTS = {
    'ALL': 'index,follow',
    'NO FOLLOW': 'index,nofollow',
    'NO INDEX': 'noindex,follow',
    'NONE': 'noindex,nofollow',
  }


  module ClassMethods
  end

end
