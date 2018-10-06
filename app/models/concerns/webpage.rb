module Webpage
  extend ActiveSupport::Concern

  included do
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
