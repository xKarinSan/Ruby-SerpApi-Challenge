require "test_helper"

class ItemPackagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @item_package = item_packages(:one)
  end

  test "should get index" do
    get item_packages_url, as: :json
    assert_response :success
  end

  test "should create item_package" do
    assert_difference("ItemPackage.count") do
      post item_packages_url, params: { item_package: { contents: @item_package.contents, name: @item_package.name } }, as: :json
    end

    assert_response :created
  end

  test "should show item_package" do
    get item_package_url(@item_package), as: :json
    assert_response :success
  end

  test "should update item_package" do
    patch item_package_url(@item_package), params: { item_package: { contents: @item_package.contents, name: @item_package.name } }, as: :json
    assert_response :success
  end

  test "should destroy item_package" do
    assert_difference("ItemPackage.count", -1) do
      delete item_package_url(@item_package), as: :json
    end

    assert_response :no_content
  end
end
