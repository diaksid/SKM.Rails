module LinkHelper

  def link_status(path)
    if path == request.path && request.query_string.blank?
      'is-active'
    elsif path != '/' and request.path.index(path) == 0
      'is-parent'
    end
  end

end
