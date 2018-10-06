class AttachedIconInput
  include Formtastic::Inputs::Base
  include ActionView::Helpers::UrlHelper
  include ImageHelper


  def to_html
    size = options.delete(:size) || 96
    variant = options.delete(:fit) ? resize_to_fit(size) : resize_to_fill(size)
    if (attached = !object.send(method).nil?)
      attached = object.send(method).attached? if object.send(method).methods.include? :attached?
    end
    image = attached ?
              object.send(method).variant(variant).processed.service_url
              :
              url_for('system/image.svg')
    attrs = {class: 'img--thumbnail',
             width: 96,
             height: 96}
    input_wrapping do
      template.image_tag(image, **attrs) <<
        template.content_tag(:small, ("%03i <em>[%03i]</em>" % [object.index, object.id]).html_safe)
    end
  end
end
