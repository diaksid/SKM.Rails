class TargetsController < ApplicationController
  include Collection

  def index
    if index_params[:area]
      area = index_params[:area].to_i
      return redirect_to targets_url(important: index_params[:important]), status: 301 if area == 0
      area = Area.active.find area
    end
    @models = (area.nil? ? Target : area.targets).navigated.weight.page params[:page]
    @title = t '.title'
    @description = t '.description', default: ''
    @header = t '.header'
    unless area.nil?
      @title += ' [%s]' % area.name
      @description += ' [%s]' % area.name
    end
    super
  end


  def show
    @model = Target.published.find show_params[:id]
    breadcrumbs t('targets.index.label', default: '<<') => targets_path
    super
  end

  private

  def index_params
    params.permit(:area, :important, :page)
  end
end
