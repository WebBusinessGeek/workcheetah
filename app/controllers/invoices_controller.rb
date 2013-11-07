class InvoicesController < ApplicationController
  before_filter :user_signed_in?
  before_filter :load_project, only: [:new, :edit]

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
    @project ||= @invoice.project
    @available_recipients = @project.users - [current_user]
  end

  def create
    @invoice = current_account.sent_invoices.new(invoice_params)

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to invoice_path(@invoice), notice: 'Invoice was successfully created.' }
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
            unless params[:recipient_name].blank? && params[:recipient_email].blank?
              @invitational = Invitational.new(
                email: params[:recipient_email],
                name: params[:recipient_name],
                type: "Invoice",
                type_id: @invoice.id
              ).save
            end
        format.html { redirect_to invoice_path(@invoice), notice: 'Invoice was successfully updated.' }
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

  private
    def load_project
      if params[:project_id]
        @project = Project.find(params[:project_id])
      end
    end

    def invoice_params
      params.require(:invoice).permit(:description, :project_id, :amount,
        line_items_attributes: [:id, :task_id, :note, :hours, :rate, :total, :_destroy])
    end
end
