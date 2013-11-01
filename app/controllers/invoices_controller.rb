class InvoicesController < ApplicationController
  before_filter :user_signed_in?

  def index
    if params[:filter]
      @invoices = current_user.account.send("#{params[:filter]}_invoices".to_sym)
    else
      @invoices = current_user.account.sent_invoices
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
    if params[:project_id]
      @project = Project.find(params[:project_id])
      @invoice = current_account.sent_invoices.new(project_id: @project.id)
    else
      @invoice = Invoice.new sender_id: current_account
    end
    @invoice.line_items.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @invoice }
    end
  end

  # GET /invoices/1/edit
  def edit
    @invoice = Invoice.find(params[:id])
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = current_account.sent_invoices.new(invoice_params)

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to invoice_path(@invoice.guid), notice: 'Invoice was successfully created.' }
        format.json { render json: @invoice, status: :created, location: @invoice }
      else
        format.html { render action: "new" }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      if @invoice.update_attributes(invoice_params)
        format.html { redirect_to invoice_path(@invoice.guid), notice: 'Invoice was successfully updated.' }
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

  private
    def invoice_params
      params.require(:invoice).permit(:description, :project_id, :amount,
        line_items_attributes: [:id, :task_id, :note, :hours, :rate, :_destroy])
    end
end
