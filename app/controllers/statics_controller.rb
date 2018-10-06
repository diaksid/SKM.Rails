class StaticsController < ApplicationController
  def home
    @title = t '.title'
    @label = ''
    @keywords = t '.keywords', default: ''
    @description = t '.description', default: ''
    @header = t '.header'
  end
end
