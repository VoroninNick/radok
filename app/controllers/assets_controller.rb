class AssetsController < ApplicationController
  before_action :set_asset, only: [:show, :edit, :update, :destroy]
  respond_to :json
  # GET /assets
  # GET /assets.json
  def index
    @assets = resource_class.all
  end

  # GET /assets/1
  # GET /assets/1.json
  def show
  end

  # GET /assets/new
  def new
    @asset = resource_class.new
  end

  # GET /assets/1/edit
  def edit
  end

  # POST /assets
  # POST /assets.json
  def create
    @asset = resource_class.new(asset_params)
    @client_attachment_index = params[:index]

    #respond_to do |format|
      if @asset.save
        #format.html { redirect_to @asset, notice: 'Asset was successfully created.' }
        #format.json {
          render "show.json", status: :created
        #}
      else
        #format.html { render :new }
        #format.json {
          render json: @asset.errors, status: :unprocessable_entity
        #}
      end
    #end
  end

  # PATCH/PUT /assets/1
  # PATCH/PUT /assets/1.json
  def update
    respond_to do |format|
      if @asset.update(asset_params)
        format.html { redirect_to @asset, notice: 'Asset was successfully updated.' }
        format.json { render :show, status: :ok, location: @asset }
      else
        format.html { render :edit }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assets/1
  # DELETE /assets/1.json
  def destroy
    @asset.destroy
    respond_to do |format|
      format.html { redirect_to assets_url, notice: 'Asset was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asset
      @asset = resource_class.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asset_params
      params[:asset]
    end

    def resource_class
      Attachable::Asset
    end
end
