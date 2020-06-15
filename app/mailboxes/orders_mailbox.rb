class OrdersMailbox < ApplicationMailbox

  def process
    match_update = mail.subject.downcase.match update_order_regexp
    notes = mail.body.decoded
    from = mail.from[0]
    if mail.subject.downcase == 'new order'
      order = Order.create!(email: from, notes: notes)
      OrderMailer.with(to: from, order_id: order.id).new_order_email.deliver_later
    elsif match_update
      order_id = match_update[1]
      order = Order.find(order_id)
      order.update email: from, notes: notes
      OrderMailer.with(to: from, order_id: order.id).updated_order_email.deliver_later
    else
      Rails.logger.info "Inbound email not processed. From: #{from}, subject: #{mail.subject}"
      OrderMailer.with(to: from, inbound_subject: mail.subject, inbound_body: notes).unprocessable_email.deliver_later
    end
  end

  private

  def update_order_regexp
    /^update order (\d\d\d\d|\d\d\d|\d\d|\d)$/
  end

end
