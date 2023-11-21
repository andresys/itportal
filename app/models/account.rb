class Account < ApplicationRecord
  has_many :assets

  # @@status: { on_balance: 0, out_balance: 1, storage: 2 }
end
