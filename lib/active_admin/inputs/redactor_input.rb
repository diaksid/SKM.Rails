class RedactorInput
  include Formtastic::Inputs::Base

  def to_html
    input_wrapping do
      label_html <<
      builder.text_area(method, input_html_options)
    end
  end


  def input_html_options
    { data: {redactor: {}} }.merge(super)
  end
end
