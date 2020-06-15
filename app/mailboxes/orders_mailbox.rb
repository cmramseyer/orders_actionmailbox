class OrdersMailbox < ApplicationMailbox

  def process
    match_update = mail.subject.downcase.match update_order_regexp
    notes = mail.body.decoded
    from = mail.from[0]
    if mail.subject.downcase == 'new order'
      Order.create!(email: from, notes: notes)
    elsif match_update
      order_id = match_update[1]
      order = Order.find(order_id)
      order.update email: from, notes: notes
    else
      Rails.logger.info "Inbound email not processed. From: #{from}, subject: #{mail.subject}"
    end
  end

  private

  def update_order_regexp
    /^update order (\d\d\d\d|\d\d\d|\d\d|\d)$/
  end

end
