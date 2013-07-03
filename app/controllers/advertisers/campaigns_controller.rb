class Advertisers::CampaignsController < Advertisers::BaseController
  before_filter :load_campaign, only: [:show, :edit, :update, :destroy]
  def index
    @campaigns = current_user.advertiser_account.campaigns
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  private
    def load_campaign
      @campaign = Campaign.find(params[:id])
    end
end
