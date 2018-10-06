class ArticlesController < ApplicationController
  include Collection

  def index
    @models = Article.navigated.page index_params[:page]
    super
  end

  def show
    @model = Article.published.find show_params[:id]
    breadcrumbs t('articles.index.label', default: '<<') => articles_path
    super
  end
end
