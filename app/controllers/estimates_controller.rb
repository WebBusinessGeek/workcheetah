class EstimatesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @estimate = Estimate.new
  end

  def create
  end

  def update
  end

  def destroy
  end

  def buy_credits
    @account = current_user.account
    if params[:selection]
      @to_buy = Estimate::PRICE.send(params[:selection])
      @response = @account.buy_credits('estimate', @to_buy)
    end
    logger.debug @response
    redirect_to request.referer
  end
end
