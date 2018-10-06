class CustomersController < ApplicationController
  include Collection

  def index
    @models = Customer.navigated.page index_params[:page]
    super
  end


  def show
    @model = Customer.published.find show_params[:id]
    breadcrumbs t('customers.index.label', default: '<<') => customers_path
    super
  end
end
