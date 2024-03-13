class AccountingController < ApplicationController
  def redirect
    if item = accounting_items.first
      redirect_to [:accounting, item.to_sym]
    else
      redirect_to root_path
    end
  end
end