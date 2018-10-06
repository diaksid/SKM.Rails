class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_host_for_local_storage, :template_vars

  private

  def set_host_for_local_storage
    ActiveStorage::Current.host = request.base_url if Rails.application.config.active_storage.service == :local
  end


  def template_vars
    @schema = {}
    @suffix = t 'application.suffix'
    @robots = 'index,follow'
    @breadcrumbs = {}
  end


  def breadcrumbs(hash)
    @breadcrumbs.merge! hash if hash.is_a? Hash
  end
end
