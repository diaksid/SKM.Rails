class ActivitiesController < ApplicationController
  include Collection

  def show
    @model = Activity.published.find show_params[:id]
    super
  end
end
