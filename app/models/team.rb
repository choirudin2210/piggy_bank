class Team < ApplicationRecord
  include Walletable
  validates :name, presence: true

  belongs_to :creator, class_name: "User", default: -> { Current.user }
  has_many :members
  has_many :users, through: :members

  after_commit :add_creator_to_member, on: :create


  def add_creator_to_member
    members.create!(user:Current.user)
  end

end
