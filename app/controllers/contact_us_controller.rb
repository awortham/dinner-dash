class ContactUsController < ApplicationController

  def new
    @contact = ContactUs.new
  end

  def create
    @contact = ContactUs.new(contact_us_params)
    @contact.request = request

    if @contact.deliver
      redirect_to root_path, notice: 'Thank you for your message. We will contact you soon!'
    else
      render :new, error: 'Cannot send message.'
    end
  end

  private

  def contact_us_params
    params.require(:contact_us).permit(:name, :email, :message, :nickname)
  end

end
