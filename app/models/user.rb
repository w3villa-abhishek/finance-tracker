class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  before_save :capitalize_name

  def limit_reach?
    return false unless stocks.count >=10
    return true  
  end

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
    return "Annonymous"
  end

  def capitalize_name
    self.first_name.capitalize!
    self.last_name.capitalize!
  end

  def self.search(value, current_user)
    if !value.nil?
      value.strip! #to remove starting/ending spaces.
      matched_profiles = (first_name_matches(value) + last_name_matches(value) + email_matches(value)).uniq
      matched_profiles = matched_profiles.reject {|profile| profile.id == current_user.id}
      return nil unless matched_profiles
      matched_profiles
    else
      return nil
    end
  end

  def self.first_name_matches(value)
    matches('first_name', value)
  end

  def self.last_name_matches(value)
    matches('last_name', value)
  end

  def self.email_matches(value)
    matches('email', value)
  end

  def self.matches(field_name,value)
    where("#{field_name} like ?", "%#{value}%")
  end

  def not_tracking?(friend_id, current_user)
    !current_user.friends.where(id: friend_id).exists?
  end

end
