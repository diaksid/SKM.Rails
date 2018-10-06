module Html5Helper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::CsrfHelper


  TagBuilder.class_eval do
    def boolean_tag_option(key)
      Slim::Engine.options[:format] == :html ? %(#{key}) : %(#{key}="#{key}")
    end
  end


  def tag(name, options = nil, open = false, escape = true)
    if Slim::Engine.options[:format] == :html
      open = true
    end
    "<#{name}#{tag_builder.tag_options(options, escape) if options}#{open ? ">" : " />"}".html_safe
  end


  def csrf_meta_tags
    if protect_against_forgery?
      [
        tag(:meta, name: 'csrf-param', content: request_forgery_protection_token),
        tag(:meta, name: 'csrf-token', content: form_authenticity_token)
      ].join("").html_safe
    end
  end

end
