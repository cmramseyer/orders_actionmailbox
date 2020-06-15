class OrderMailer < ApplicationMailer

  def new_order_email
    @recipient = params[:to]
    @order = Order.find(params[:order_id])
    subject = "Your order has been created!"
    mail(to: @recipient, subject: subject)
  end

  def updated_order_email
    @recipient = params[:to]
    @order = Order.find(params[:order_id])
    subject = "Your order has been updated!"
    mail(to: @recipient, subject: subject)
  end

  def unprocessable_email
    @recipient = params[:to]
    @inbound_subject = params[:inbound_subject]
    @inbound_body = params[:inbound_body]
    subject = "Your email could not be processed"
    mail(to: @recipient, subject: subject)
  end
end
