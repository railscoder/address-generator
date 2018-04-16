class BitcoinAddress < ApplicationRecord
	scope :not_withdrawn, -> { where(funds_withdrawn: false) }
	scope :not_zero_balance, -> { where.not(amount: 0) }
end
