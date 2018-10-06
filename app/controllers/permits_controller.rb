class PermitsController < ApplicationController
  include Collection

  def index
    @models = Permit.navigated.page index_params[:page]
    super
  end

  def show
    @model = Permit.published.find show_params[:id]
    breadcrumbs t('permits.index.label', default: '<<') => permits_path
    super
  end
end
