class User::CommunitiesController < ApplicationController
  def index
    @communities = Community.all.order('created_at DESC').page(params[:page]).per(3)
  end
  
  def show
    @community = Community.find(params[:id])
    @communities = Community.all
  end
end
