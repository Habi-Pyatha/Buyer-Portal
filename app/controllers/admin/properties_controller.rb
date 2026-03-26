class Admin::PropertiesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def index
    @properties = Property.all
  end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)
    if @property.save
      redirect_to admin_properties_path, notice: "Property created successfully"
    else
      render :new
    end
  end

  def edit
    @property = Property.find(params[:id])
  end

  def update
    @property = Property.find(params[:id])
    if @property.update(property_params)
      redirect_to admin_properties_path, notice: "Property updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @property = Property.find(params[:id])
    @property.destroy
    redirect_to admin_properties_path, notice: "Property deleted"
  end

  private

  def check_admin
    redirect_to root_path, alert: "Access denied" unless current_user.admin?
  end

  def property_params
    params.require(:property).permit(:title, :address, :price, :description, :image_url)
  end
end
