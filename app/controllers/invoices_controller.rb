class InvoicesController < ApplicationController
  before_filter :user_signed_in?
  before_filter :load_project, only: [:new, :edit]

  def index
    if params[:filter]
      @invoices = current_user.account.send("#{params[:filter]}_invoices".to_sym)
    else
      @invoices = current_user.account.sent_invoices + current_user.account.recieved_invoices
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @invoices }
    end
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
    @invoice = Invoice.find_by_guid(params[:guid])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @invoice }
    end
  end

  # GET /invoices/new
  # GET /invoices/new.json
  def new
    if @project
      @invoice = current_account.sent_invoices.new(project_id: @project.id)
      @available_recipients = @project.users - [current_user]
    else
      @invoice = Invoice.new sender_id: current_account.id
      @available_recipients = current_user.clients
    end
    @invoice.line_items.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @invoice }
    end
  end

  def edit
    @invoice = Invoice.find_by_guid(params[:guid])
    if @invoice.project
      @available_recipients = @invoice.project.users - [current_user] + current_user.clients
    else
      @available_recipients = current_user.clients
    end
  end

  def create
    @invoice = current_account.sent_invoices.new(invoice_params)

    respond_to do |format|
      if @invoice.save
        if params[:submit] == 'Send Invoice'
          @invoice.send_invoice
          msg = 'Invoice has been send for approval'
        else
          msg = 'Invoice was successfully created.'
        end
        format.html { redirect_to invoice_path(@invoice), notice: msg }
        format.json { render json: @invoice, status: :created, location: @invoice }
      else
        if @invoice.project
          @available_recipients = @invoice.project.users - [current_user]
        else
          @available_recipients = current_user.clients
        end
        logger.debug @invoice.errors.inspect
        format.html { render action: "new" }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    @invoice = Invoice.find_by_guid(params[:id])
    @invoice = Invoice.find(params[:id]) unless @invoice

    respond_to do |format|
      if @invoice.update_attributes(invoice_params)
        unless params[:recipient_name].blank? && params[:recipient_email].blank?
          @invitational = Invitational.new(
            email: params[:recipient_email],
            name: params[:recipient_name],
            type: "Invoice",
            type_id: @invoice.id
          ).save
        end
        if params[:commit] == 'Send Invoice'
          @invoice.send_invoice
          msg = 'Invoice has been send for approval'
        else
          msg = 'Invoice was successfully updated.'
        end
        format.html { redirect_to invoice_path(@invoice), notice: msg }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice = Invoice.find(params[:id])
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to invoices_url }
      format.json { head :no_content }
    end
  end

  def invite
    @invitational = Invitational.new(
      )
  end

  def pay
    @invoice = Invoice.find_by_guid(params[:id])
    if params[:data] == "pay"
      @invoice.accept
      @invoice.charge
      redirect_to @invoice, notice: "Invoice Paid and awaiting transfer"
    elsif params[:data == "transfer"]
    end
  end

  private
    def load_project
      if params[:project_id]
        @project = Project.find(params[:project_id])
      end
    end

    def invoice_params
      params.require(:invoice).permit(:description, :project_id, :amount, :reciever_id,
        line_items_attributes: [:id, :task_id, :note, :hours, :rate, :total, :_destroy])
    end
end
