class Advertisers::AdvertisementsController < Advertisers::BaseController
  # GET /advertisers/advertisements
  # GET /advertisers/advertisements.json
  def index
    @advertisers_advertisements = Advertisers::Advertisement.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @advertisers_advertisements }
    end
  end

  # GET /advertisers/advertisements/1
  # GET /advertisers/advertisements/1.json
  def show
    @advertisers_advertisement = Advertisers::Advertisement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @advertisers_advertisement }
    end
  end

  # GET /advertisers/advertisements/new
  # GET /advertisers/advertisements/new.json
  def new
    @advertisers_advertisement = Advertisers::Advertisement.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @advertisers_advertisement }
    end
  end

  # GET /advertisers/advertisements/1/edit
  def edit
    @advertisers_advertisement = Advertisers::Advertisement.find(params[:id])
  end

  # POST /advertisers/advertisements
  # POST /advertisers/advertisements.json
  def create
    @advertisers_advertisement = Advertisers::Advertisement.new(advertisers_advertisement_params)

    respond_to do |format|
      if @advertisers_advertisement.save
        format.html { redirect_to @advertisers_advertisement, notice: 'Advertisement was successfully created.' }
        format.json { render json: @advertisers_advertisement, status: :created, location: @advertisers_advertisement }
      else
        format.html { render action: "new" }
        format.json { render json: @advertisers_advertisement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /advertisers/advertisements/1
  # PATCH/PUT /advertisers/advertisements/1.json
  def update
    @advertisers_advertisement = Advertisers::Advertisement.find(params[:id])

    respond_to do |format|
      if @advertisers_advertisement.update_attributes(advertisers_advertisement_params)
        format.html { redirect_to @advertisers_advertisement, notice: 'Advertisement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @advertisers_advertisement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /advertisers/advertisements/1
  # DELETE /advertisers/advertisements/1.json
  def destroy
    @advertisers_advertisement = Advertisers::Advertisement.find(params[:id])
    @advertisers_advertisement.destroy

    respond_to do |format|
      format.html { redirect_to advertisers_advertisements_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def advertisers_advertisement_params
      params.require(:advertisers_advertisement).permit(:campaign_id, :confirmed, :end_time, :height, :priority, :start_time, :text, :title, :url, :width)
    end
end
