class UsersController < ApplicationController
   before_action :authenticate_user! , only: [:my_portfolio] 
    
  def my_portfolio
    @count = 0
    @user = current_user
    @my_stocks = @user.stocks
    flash[:alert] = "you have reached your maximum limit to add stocks in your portfolio" if current_user.limit_reach?
  end

  def tracked_profiles
    if params[:user]
      user = User.find(params[:user])
       if current_user.friends << user
          flash[:notice] = "Friend added to the tracking list successfully.."
       end
    end
    @tracked_profiles = current_user.friends
    @count = 0
  end

  def tracked_portfolio
    @count = 0
    @user = User.find(params[:user])
    @my_stocks = @user.stocks
  end

  def stop_tracking
    row = Friendship.where(user: current_user, friend: params[:friend]).first
    row.destroy
    flash[:notice] = "Friend removed from the tracking list successfully"
    redirect_to tracked_profiles_path
  end

  def add_friends
    @count = 0
    @matched_profiles = User.search(params[:friend], current_user)
    flash.now[:alert] = "no profile matched with your search..." if @matched_profiles && @matched_profiles.empty?
  end

end
