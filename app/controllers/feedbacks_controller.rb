class FeedbacksController < ApplicationController
  include Collection

  def index
    @models = Feedback.navigated.page index_params[:page]
    super
  end

  def show
    @model = Feedback.published.find show_params[:id]
    breadcrumbs t('feedbacks.index.label', default: '<<') => feedbacks_path
    super
  end
end
