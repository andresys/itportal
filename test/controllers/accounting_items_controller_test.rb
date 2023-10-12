require "test_helper"

class AccountingItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @accounting_item = accounting_items(:one)
  end

  test "should get index" do
    get accounting_items_url
    assert_response :success
  end

  test "should get new" do
    get new_accounting_item_url
    assert_response :success
  end

  test "should create accounting_item" do
    assert_difference('AccountingItem.count') do
      post accounting_items_url, params: { accounting_item: {  } }
    end

    assert_redirected_to accounting_item_url(AccountingItem.last)
  end

  test "should show accounting_item" do
    get accounting_item_url(@accounting_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_accounting_item_url(@accounting_item)
    assert_response :success
  end

  test "should update accounting_item" do
    patch accounting_item_url(@accounting_item), params: { accounting_item: {  } }
    assert_redirected_to accounting_item_url(@accounting_item)
  end

  test "should destroy accounting_item" do
    assert_difference('AccountingItem.count', -1) do
      delete accounting_item_url(@accounting_item)
    end

    assert_redirected_to accounting_items_url
  end
end
