module InvoicesHelper
  def formatted_address(account)
    return "<address>
        <strong>#{account.name}</strong><br>
        No address available
        </address>".html_safe if account.owner.nil?
    @address = account.owner.resume ? account.owner.resume.addresses.first : nil
    if @address
      data = "<address>
        <strong>#{@address.addressable.name}</strong><br>
        #{@address.address_1}, #{@address.address_2}<br>
        #{@address.city}, #{@address.state} #{@address.zip}
      </address>".html_safe
    else
      data = "<address>
        <strong>#{account.name}</strong><br>
        No address available
        </address>".html_safe
    end
    return data
  end

  def format_states(invoice)
    case invoice.state
    when 'draft'
      @title = "Drafted"
      @msg = "Invoice is in drafting and awaiting to be sent to a client."
    when 'sent'
      @title = "Sent"
      @msg = "Invoice has been sent for approval."
    when 'pending'
      @title = "Pending"
      @msg = "Payment Processing is currently pending, check back later."
    when 'processing'
      @title = "Processing"
      @msg = "Invoice is currently being processed for payment"
    when 'payout'
      @title = "Awaiting Payout"
      @msg = "Invoice has been successfully paid and awaiting payout. The system will initiate a transfer request by end of business day."
    when 'escrowed'
      @title = "Funds in Escrow"
      @msg = "Funds are in escrow awaiting transfer approval from the client."
    when 'finished'
      @title = "Completed"
      @msg = "Invoice has been paid and requested funds transfered."
    when 'errored'
      @title = "Error processing payment"
      @msg = "#{invoice.error}"
    end
    return link_to "#{@title}", "javascript:void(0);", rel: "tooltip", data: {toggle: "tooltip", title: "#{@msg}"}
  end

  def sent_on_date(invoice)
    if invoice.state == 'draft'
      content_tag :p do
        content_tag :small do
          "Updated: #{localize(invoice.updated_at, format: :short)}"
        end
      end
    else
      ""
    end
  end
end
