module InvoicesHelper
  def formatted_address(address)
    "<address>
      <strong>#{address.addressable.name}</strong><br>
      #{address.address_1}, #{address.address_2}<br>
      #{address.city}, #{address.state} #{address.zip}
    </address>".html_safe
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
