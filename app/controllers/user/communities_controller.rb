class User::CommunitiesController < ApplicationController
  def index
    @communities = Community.all.order(comment_count: :desc)
  end
  
  def show
    @community = Community.find(params[:id])
    @communities = Community.all
  end
end
