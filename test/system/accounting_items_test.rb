require "application_system_test_case"

class AccountingItemsTest < ApplicationSystemTestCase
  setup do
    @accounting_item = accounting_items(:one)
  end

  test "visiting the index" do
    visit accounting_items_url
    assert_selector "h1", text: "Accounting Items"
  end

  test "creating a Accounting item" do
    visit accounting_items_url
    click_on "New Accounting Item"

    click_on "Create Accounting item"

    assert_text "Accounting item was successfully created"
    click_on "Back"
  end

  test "updating a Accounting item" do
    visit accounting_items_url
    click_on "Edit", match: :first

    click_on "Update Accounting item"

    assert_text "Accounting item was successfully updated"
    click_on "Back"
  end

  test "destroying a Accounting item" do
    visit accounting_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Accounting item was successfully destroyed"
  end
end
