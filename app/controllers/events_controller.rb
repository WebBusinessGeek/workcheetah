class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def ajax_events
    @r = Array.new()
    @events = current_user.events.all.collect {|e| @r.push(:id => e.id, :start => e.start, :title => e.title.truncate(8))}

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @r }
    end
  end
  
  def index
    @events = current_user.events.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = current_user.events.find(params[:id])
    render layout: false
    return
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = current_user.events.build
    render layout: false
    return
  end

  # GET /events/1/edit
  def edit
    @event = current_user.events.find(params[:id])
    render layout: false
    return
  end

  # POST /events
  # POST /events.json
  def create
    @event = current_user.events.build(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to root_url, notice: 'Event was successfully created!' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    @event = current_user.events.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(event_params)
        format.html { redirect_to freelancer_path, notice: 'Event was successfully updated!' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = current_user.events.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to freelancer_path, notice: 'Event was successfully deleted!' }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def event_params
      params.require(:event).permit(:title, :start)
    end
end
