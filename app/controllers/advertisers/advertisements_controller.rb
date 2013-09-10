class Advertisers::AdvertisementsController < Advertisers::BaseController
  before_filter :load_advertisement, only: [:show, :edit, :update, :destroy, :toggle, :click_through]

  respond_to :html, :js
  def index
    @advertisements = current_user.advertiser_account.campaigns.advertisements
  end

  def show
  end

  def new
    @type = params[:type]
    @campaign = Campaign.find(params[:campaign_id])
    @advertisement = @campaign.advertisements.build
  end

  def edit
    @campaign = @advertisement.campaign
  end

  def create
    @advertisement = Advertisement.new(advertisement_params)

    if @advertisement.save
      flash[:notice] = 'Advertisement was successfully created.'
      redirect_to advertisers_advertisement_path @advertisement
    else
      render action: :new
    end
  end

  def update
    if @advertisement.update_attributes(advertisement_params)
      flash[:notice] = 'Advertisement was successfully updated.'
      respond_with @advertisement, location: advertisers_advertisement_path
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

  def click_through
    @advertisement.stat_incrementor "click"
    redirect_to @advertisement.url
  end

  def image_ad
    @advertisement = ImageAd.first
    @advertisement.stat_incrementor "impression"
    render layout: false
  end
  def text_ad
    @advertisement = TextAd.first
    @advertisement.stat_incrementor "impression"
    render layout: false
  end

  private
    def load_advertisement
      @advertisement = Advertisement.find(params[:id])
    end
    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def advertisement_params
      params.require(:advertisement).permit(:campaign_id, :confirmed, :end_time, :height, :priority, :ad_type,
        :start_time, :content, :image, :title, :url, :width)
    end
end
