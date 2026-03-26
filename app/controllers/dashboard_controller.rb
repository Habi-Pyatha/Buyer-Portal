class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @favourites = current_user.favourites.includes(:property)
  end
end
