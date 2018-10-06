class UploadIconInput
  include Formtastic::Inputs::Base

  def to_html
    input_wrapping do
      template.imagic_tag(object.send(method).icon) <<
      if method == :upload
        template.content_tag(:small, "# #{object.id} (#{object.send(method).width}x#{object.send(method).height})")
      else
        template.content_tag(:small, "# #{object.id}")
      end
    end
  end

end
