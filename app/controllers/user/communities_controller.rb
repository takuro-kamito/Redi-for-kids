class User::CommunitiesController < ApplicationController
  def index
    @communities = Community.all
  end
  
  def show
    @community = Community.find(params[:id])
    @communities = Community.all
  end
end
