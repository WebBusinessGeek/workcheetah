class Advertisers::InvoicesController < Advertisers::BaseController
  def index
    @invoices = current_user.advertiser_account.advertiser_invoices
  end

  def show
    @invoice = AdvertiserInvoice.find_by_guid(params[:guid])
  end
end
