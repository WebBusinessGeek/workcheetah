class Advertisers::CampaignsController < Advertisers::BaseController
  before_filter :load_campaign, only: [:edit, :update, :destroy, :toggle]
  def index
    @campaigns = Advertisers::CurrentCampaigns.new(current_user.advertiser_account).active
  end

  def show
    @campaign = Campaign.includes(:advertisements).find(params[:id])
  end

  def new
    @campaign = current_user.advertiser_account.campaigns.build
  end

  def edit
  end

  def create
    @campaign = current_user.advertiser_account.campaigns.build(campaign_parms)
    @campaign.active = true # active for now
    if @campaign.save!
      redirect_to advertisers_campaigns_path, notice: "Campaign Created Successfully."
    else
      render action: :new
    end
  end

  def update
    @campaign.assign_attributes(campaign_parms)
    if @campaign.save!
      redirect_to advertisers_campaign_path @campaign, notice: "Campaign Updated Successfully"
    else
      render action: :edit
    end
  end

  def destroy
    @campaign.update_attributes(active: false)
  end

  def toggle
    @campaign.toggle_status!
    redirect_to :back
  end

  private
    def load_campaign
      @campaign = Campaign.find(params[:id])
    end

    def campaign_parms
      params.require(:campaign).permit(:name, :budget, :start_date, :end_date)
    end
end
