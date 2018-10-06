class ContactController < ApplicationController
  def show
    @schema = {page: 'ContactPage'}
    @title = t 'contact.show.title'
    @keywords = t 'contact.show.keywords', default: ''
    @description = t 'contact.show.description', default: ''
    @header = t 'contact.show.header'
  end


  def deliver
    @model = ContactForm.new(deliver_params)
    if @model.valid?
      if ContactMailer.contact_form(@model).deliver
        flash[:notice] = 'Сообщение отправлено...'
      else
        flash[:alert] = 'Ошибка отправки сообщения...'
      end
    else
      flash[:alert] = 'Ошибка создания сообщения...'
    end
    redirect_back fallback_location: contact_path
  end

  private

  def deliver_params
    params.require(:contact).permit(:name, :email, :phone, :subject, :content)
  end
end
