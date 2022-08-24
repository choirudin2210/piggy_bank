require "test_helper"

class Wallets::TransfersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wallets_transfer = wallets_transfers(:one)
  end

  test "should get index" do
    get wallets_transfers_url
    assert_response :success
  end

  test "should get new" do
    get new_wallets_transfer_url
    assert_response :success
  end

  test "should create wallets_transfer" do
    assert_difference("Wallets::Transfer.count") do
      post wallets_transfers_url, params: { wallets_transfer: {  } }
    end

    assert_redirected_to wallets_transfer_url(Wallets::Transfer.last)
  end

  test "should show wallets_transfer" do
    get wallets_transfer_url(@wallets_transfer)
    assert_response :success
  end

  test "should get edit" do
    get edit_wallets_transfer_url(@wallets_transfer)
    assert_response :success
  end

  test "should update wallets_transfer" do
    patch wallets_transfer_url(@wallets_transfer), params: { wallets_transfer: {  } }
    assert_redirected_to wallets_transfer_url(@wallets_transfer)
  end

  test "should destroy wallets_transfer" do
    assert_difference("Wallets::Transfer.count", -1) do
      delete wallets_transfer_url(@wallets_transfer)
    end

    assert_redirected_to wallets_transfers_url
  end
end
