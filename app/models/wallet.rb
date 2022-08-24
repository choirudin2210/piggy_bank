class Wallet < ApplicationRecord
  belongs_to :owner, polymorphic: true
  has_many :debit_transactions, class_name:"Transaction", :foreign_key => :to_wallet_id
  has_many :credit_transactions, class_name:"Transaction", :foreign_key => :from_wallet_id

  def sufficient_balance(amount)
    return true if balance >= amount
    raise StandardError.new "Insufficient Balance"
  end

  def deposit(sender, amount)
    ActiveRecord::Base.transaction do
      return unless sender.sufficient_balance(amount)
      last_balance = self.balance.clone
      self.balance = self.balance + amount
      test = Transaction.create(to_wallet_id: self.id, from_wallet_id: sender.id, transaction_type: Transaction.transaction_types[:debit], amount: amount, last_balance: last_balance ) # debit
      Rails.logger.info(test.errors.inspect) 

      update_wallet_balance_for_sender(sender, amount)
      save!
    end
  end

  def withdraw(receiver, amount)
    ActiveRecord::Base.transaction do
      return unless sufficient_balance(amount)
      last_balance = self.balance.clone
      self.balance = self.balance - amount 
      test = Transaction.create(to_wallet_id: self.id, from_wallet_id: receiver.id, transaction_type: Transaction.transaction_types[:credit], amount: amount, last_balance: last_balance)
      Rails.logger.info(test.errors.inspect)
      update_wallet_balance_for_receiver(receiver, amount)
      save!
    end
  end


  private

  def update_wallet_balance_for_sender(sender, amount)
    sender.balance = sender.balance - amount
    test = Transaction.create(to_wallet_id: sender.id, from_wallet_id: self.id, transaction_type: Transaction.transaction_types[:credit], amount: amount, last_balance: sender.balance )
    Rails.logger.info(test.errors.inspect)
    sender.save!
  end

  def update_wallet_balance_for_receiver(receiver, amount)
    last_balance = receiver.balance.clone
    receiver.balance = receiver.balance + amount
    test = Transaction.create(to_wallet_id: receiver.id, from_wallet_id: self.id, transaction_type: Transaction.transaction_types[:debit], amount: amount, last_balance: last_balance )
    Rails.logger.info(test.errors.inspect)
    receiver.save!
  end

end
