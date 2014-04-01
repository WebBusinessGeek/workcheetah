class PaymentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_payment, only: [:show, :edit, :update, :destroy]
  def index
    @payments = current_user.transfer_payments
    if ['freelancer', 'business'].include? current_user.role
      @payments += current_user.account.payments
    end
  end

  def show
  end

  def new
    @payment = ShiftPaymentForm.new(user_id: params[:user_id], biller_id: current_user.account_id)
  end

  def edit
  end

  def create
    @payment = ShiftPaymentForm.new(params[:shift_payment_form])
    @response = @payment.save
    if @response
      @response.charge
      redirect_to payments_path, notice: "Payment made successfully."
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private
    def get_payment
      @payment = Payment.find(params[:id])
    end
end
