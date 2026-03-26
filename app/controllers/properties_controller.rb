class PropertiesController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  before_action :set_property, only: [ :show, :favourite ]

  def index
    @properties = Property.all
  end

  def show
    @favourited = current_user.favourites.find_by(property: @property) if user_signed_in?
  end

  def favourite
    if request.delete?
      favourite = current_user.favourites.find_by(property: @property)
      favourite&.destroy
      flash[:notice] = "Property removed from favourites"
    else
      current_user.favourites.find_or_create_by(property: @property)
      flash[:notice] = "Property added to favourites"
    end
    redirect_to @property
  end

  private

  def set_property
    @property = Property.find(params[:id])
  end
end
