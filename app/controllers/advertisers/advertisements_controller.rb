class Advertisers::AdvertisementsController < Advertisers::BaseController
  before_filter :load_advertisement, only: [:show, :edit, :update, :destroy, :toggle]

  respond_to :html, :js
  def index
    @advertisements = current_user.advertiser_account.campaigns.advertisements
  end

  def show
  end

  def new
    @campaign = Campaign.find(params[:campaign_id])
    @advertisement = @campaign.advertisements.build
  end

  def edit
    @campaign = @advertisement.campaign
  end

  def create
    @advertisement = Advertisement.new(advertisement_params)

    if @advertisement.save
      redirect_to advertisers_advertisement_path @advertisement, notice: 'Advertisement was successfully created.'
    else
      render action: :new
    end
  end

  def update
    if @advertisement.update_attributes(advertisement_params)
      respond_with @advertisement, location: advertisers_advertisement_path,
        notice: 'Advertisement was successfully updated.'
    else
      render action: :edit
    end
  end

  def destroy
    @advertisement.destroy
  end

  def toggle
    @advertisement.toggle!
    redirect_to :back
  end

  private
    def load_advertisement
      @advertisement = Advertisement.find(params[:id])
    end
    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def advertisement_params
      params.require(:advertisement).permit(:campaign_id, :confirmed, :end_time, :height, :priority, :start_time, :content, :image, :title, :url, :width)
    end
end
