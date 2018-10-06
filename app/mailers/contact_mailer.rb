class ContactMailer < ApplicationMailer
  def contact_form(model)
    @model = model

    mail(from: %("#{model.name}" <#{model.email}>),
         subject: %(#{model.subject.empty? ? 'контактная форма' : model.subject}))
  end
end
