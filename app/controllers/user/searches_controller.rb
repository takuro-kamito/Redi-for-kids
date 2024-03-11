class User::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
  @model = params[:model]
  @content = params[:content]
  @method = params[:method]
  
  if @model == 'User'
    @records = User.search_for(@content, @method)
  else
    @records  = Community.search_for(@content, @method)
  end

  render 'search_results'
 end
end 