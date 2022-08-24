module Walletable
  extend ActiveSupport::Concern

  included do
    has_one :wallet, :as => :owner
    after_commit :create_wallet, on: :create
    delegate :balance, to: :wallet
  end

  def create_wallet
    build_wallet.save
  end
  
end