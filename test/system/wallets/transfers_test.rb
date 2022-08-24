require "application_system_test_case"

class Wallets::TransfersTest < ApplicationSystemTestCase
  setup do
    @wallets_transfer = wallets_transfers(:one)
  end

  test "visiting the index" do
    visit wallets_transfers_url
    assert_selector "h1", text: "Transfers"
  end

  test "should create transfer" do
    visit wallets_transfers_url
    click_on "New transfer"

    click_on "Create Transfer"

    assert_text "Transfer was successfully created"
    click_on "Back"
  end

  test "should update Transfer" do
    visit wallets_transfer_url(@wallets_transfer)
    click_on "Edit this transfer", match: :first

    click_on "Update Transfer"

    assert_text "Transfer was successfully updated"
    click_on "Back"
  end

  test "should destroy Transfer" do
    visit wallets_transfer_url(@wallets_transfer)
    click_on "Destroy this transfer", match: :first

    assert_text "Transfer was successfully destroyed"
  end
end
