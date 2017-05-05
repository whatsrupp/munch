class RestaurantsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = current_user.restaurants.create(restaurant_params)
    if @restaurant.save
      redirect_to restaurants_path
    else
      render 'new'
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    unless current_user == @restaurant.user
      redirect_to('/restaurants', notice: "You cannot edit this restaurant") and return
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)
    redirect_to '/restaurants'
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :image)
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    unless current_user == @restaurant.user
      redirect_to('/restaurants', notice: "You cannot delete this restaurant") and return
    end
    @restaurant.destroy
    flash[:notice] = 'Restaurant deleted successfully'
    redirect_to '/restaurants'
  end
end
