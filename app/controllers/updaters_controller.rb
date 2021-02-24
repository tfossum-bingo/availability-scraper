class UpdatersController < ApplicationController
  before_action :set_updater, only: %i[ edit update destroy ]

  # GET /updaters or /updaters.json
  def index
    # @listings = Listing.all.order(airbnb_id: :asc)
    # respond_to do |format|
    #   format.json { render json: @listings}
    # end
  end

  # GET /updaters/1 or /updaters/1.json
  def show
    @listings = Listing.where(host_id: params[:id]).order(airbnb_id: :asc)
    respond_to do |format|
      format.json { render json: @listings}
    end
  end

  # GET /updaters/new
  def new
    @updater = Updater.new
  end

  # GET /updaters/1/edit
  def edit
  end

  # POST /updaters or /updaters.json
  def create
    @updater = Updater.new(updater_params)

    respond_to do |format|
      if @updater.save
        format.html { redirect_to @updater, notice: "Updater was successfully created." }
        format.json { render :show, status: :created, location: @updater }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @updater.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /updaters/1 or /updaters/1.json
  def refresh_data
    RefreshDataJob.perform_later()
    redirect_to hosts_path, notice: "Data refresh has been scheduled."
  end
  #
  # # DELETE /updaters/1 or /updaters/1.json
  # def destroy
  #   @updater.destroy
  #   respond_to do |format|
  #     format.html { redirect_to updaters_url, notice: "Updater was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_updater
      @updater = Updater.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def updater_params
      params.fetch(:updater, {})
    end
end
