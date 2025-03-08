class ItemPackagesController < ApplicationController
  before_action :set_item_package, only: %i[ show update destroy ]

  # GET /item_packages
  def index
    @item_packages = ItemPackage.all
    render json: @item_packages
  end

  # GET /item_packages/1
  def show
    render json: @item_package
  end

  # POST /item_packages
  def create
    @item_package = ItemPackage.new(item_package_params)
    unless @item_package.valid?  # Check if validation fails
      raise ActionController::ParameterMissing.new(@item_package)  
    end
    if @item_package.save
      render json: @item_package, status: :created, location: @item_package
    end
  rescue ActionController::ParameterMissing => e
    render json: { error: "Required parameters are missing: #{e.message}" }, status: :bad_request
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  # PATCH/PUT /item_packages/1
  def update
    if @item_package.update(item_package_params)
      render json: @item_package
    else
      render StandardError
    end
  rescue StandardError =>e 
    render json: {error:e.message},status: :internal_server_error
  end

  # DELETE /item_packages/1
  def destroy
    res = @item_package.destroy!
    render json: {message:"Package deleted!"}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_package
      @item_package = ItemPackage.find(params.expect(:id))
    rescue ActiveRecord::RecordNotFound
      Rails.logger.error "set_item_package - #{{"id" => params[:id]}} - package not found"
      render json: {error:"Item package not found"},status: :not_found and return
    end

    # Only allow a list of trusted parameters through.
    def item_package_params
    params.require(:item_package).permit(:name, :contents)
    rescue ActionController::ParameterMissing => e
      Rails.logger.error 'item_package_params - Missing required parameters';
      render json: { error: "Required parameters are missing: #{e.message}" }, status: :bad_request and return
    end
end
