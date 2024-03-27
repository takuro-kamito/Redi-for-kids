class User::HomesController < ApplicationController
  def top
    @community = Community.all.order('created_at DESC').page(params[:page]).per(3)
  end

  def about
  end
end
