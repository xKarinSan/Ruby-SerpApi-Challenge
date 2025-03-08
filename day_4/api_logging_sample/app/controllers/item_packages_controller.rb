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

    if @item_package.save
      render json: @item_package, status: :created, location: @item_package
    else
      render json: @item_package.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /item_packages/1
  def update
    if @item_package.update(item_package_params)
      render json: @item_package
    else
      render json: @item_package.errors, status: :unprocessable_entity
    end
  end

  # DELETE /item_packages/1
  def destroy
    @item_package.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_package
      @item_package = ItemPackage.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def item_package_params
      params.expect(item_package: [ :name, :contents ])
    end
end
