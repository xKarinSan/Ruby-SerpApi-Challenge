class ItemPackagesController < ApplicationController
  before_action :set_item_package, only: %i[ show update destroy ]

  # GET /item_packages
  def index
    @item_packages = ItemPackage.all
    render json: @item_packages.as_json(only:[:name,:contents])
  end

  # GET /item_packages/1
  def show
    render json: @item_package.as_json(only:[:name,:contents])
  rescue StandardError =>e 
    render json: {error:e.message},status: :internal_server_error
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
    rescue ActiveRecord::RecordNotFound
      render json: {error:"Item package not found"},status: :not_found
    rescue ActionController::ParameterMissing
      render json: {error:"Missing required parameters"},status: :bad_request
    end

    # Only allow a list of trusted parameters through.
    def item_package_params
      params.expect(item_package: [ :name, :contents ])
    rescue ActionController::ParameterMissing => e
      render json: { error: "Required parameters are missing: #{e.message}" }, status: :bad_request
    end
end
