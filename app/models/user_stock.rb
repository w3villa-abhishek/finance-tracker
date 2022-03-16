class UserStock < ApplicationRecord
  belongs_to :user
  belongs_to :stock


  def self.add_or_not(user, stock)
    where(user: user, stock: stock)
  end
end
