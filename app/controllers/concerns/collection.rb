module Collection
  extend ActiveSupport::Concern

  included do
  end


  def index
    @title ||= t '.title'
    @description ||= t '.description', default: ''
    @keywords ||= t '.keywords', default: ''
    @header ||= t '.header'

    @schema = {page: 'CollectionPage',
               main: 'DataCatalog'}

    if index_params[:page]
      @title += " # #{index_params[:page]}"
      @description += " # #{index_params[:page]}"
    end
  end


  def show
    @title ||= @model.title.blank? ? @model.name : @model.title
    @keywords ||= @model.keywords
    @description ||= @model.description
    @header ||= @model.header.blank? ? @model.name : @model.header

    @schema = {page: 'ItemPage',
               main: 'Dataset'}

    if defined?(@model) && current_user && current_user.admin?
      breadcrumbs admin: url_for(id: @model.id ,
                                 action: :edit,
                                 controller: 'admin/%s' % @model.class.to_s.downcase.pluralize)
    end
  end

  private

  def index_params
    params.permit(:page)
  end


  def show_params
    params.permit(:id)
  end


  module ClassMethods
  end

end
