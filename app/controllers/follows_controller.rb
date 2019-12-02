# frozen_string_literal: true

class FollowsController < ApplicationController
  before_action :logged_in_user, :find_user
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Follow.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  private

  def find_user
    @user = User.find(params[:followed_id])
  end
end
