module InvoicesHelper
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
