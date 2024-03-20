class User::HomesController < ApplicationController
  def top
    @community = Community.order("id DESC").limit(8)
  end

  def about
  end
end
