module InvoicesHelper
  def formatted_address(account)
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
