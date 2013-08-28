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
    @campaign = current_user.advertiser_account.campaigns.build(campaign_params)
    @campaign.active = true # active for now
    if @campaign.save!
      flash[:notice] = "Campaign Created Successfully."
      redirect_to advertisers_campaigns_path
    else
      render action: :new
    end
  end

  def update
    @campaign.assign_attributes(campaign_params)
    if @campaign.save!
      flash[:notice] = "Campaign Updated Successfully"
      redirect_to advertisers_campaign_path @campaign
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

    def campaign_params
      params.require(:campaign).permit(:name, :cpc, :audience_target_ids,
        :industry_target_ids, :job_target_ids, :employee_target_ids, :education_target_ids,
        :advertiser_target_ids,
        image_ads_attributes: [:title],
        text_ads_attributes: [:title])
    end
end
