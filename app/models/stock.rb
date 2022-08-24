class Stock < ApplicationRecord
	include Walletable
	validates :name, presence: true
end
