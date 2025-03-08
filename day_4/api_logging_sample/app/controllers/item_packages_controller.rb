class ItemPackagesController < ApplicationController
  before_action :set_item_package, only: %i[ show update destroy ]

  # GET /item_packages
  def index
    @item_packages = ItemPackage.all
    Rails.logger.info 'GET /item_packages 200'
    render json: @item_packages
  end

  # GET /item_packages/1
  def show
    render json: @item_package
  end

  # POST /item_packages
  def create
    @item_package = ItemPackage.new(item_package_params)

    if @item_package.save
      render json: @item_package, status: :created, location: @item_package
    else
      render json: @item_package.errors, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
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
      render json: @item_package.errors, status: :unprocessable_entity
    end
  rescue StandardError =>e 
    render json: {error:e.message},status: :internal_server_error
  end

  # DELETE /item_packages/1
  def destroy
    @item_package.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_package
      @item_package = ItemPackage.find(params.expect(:id))
      Rails.logger.info "Package of ##{params[:id]} accessed"
    rescue ActiveRecord::RecordNotFound
      Rails.logger.error "Package of ##{params[:id]} is not found"
      render json: {error:"Item package not found"},status: :not_found and return
    rescue ActionController::ParameterMissing
      Rails.logger.error 'Missing required parameters';
      render json: {error:"Missing required parameters"},status: :bad_request and return
    end

    # Only allow a list of trusted parameters through.
    def item_package_params
    params.require(:item_package).permit(:name, :contents)
    rescue ActionController::ParameterMissing => e
      Rails.logger.error 'Missing required parameters';
      render json: { error: "Required parameters are missing: #{e.message}" }, status: :bad_request and return
    end
end
