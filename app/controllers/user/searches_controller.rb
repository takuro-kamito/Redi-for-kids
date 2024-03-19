class User::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
  @model = params[:model]
  @search_form = params[:search_form]
  @method = params[:method]
  @word = params[:word]
  
  if @model == 'User'
    if @method == "partial_match"
      @records = User.where("name LIKE ?", "%#{@search_form}%")
    elsif @method == "forward_match"
      @records = User.where("name LIKE ?", "#{@search_form}%")
    else
      @records = User.all
    end
  else
    if @method == "partial_match"
      @records = Community.where("name LIKE ?", "%#{@search_form}%")
    elsif @method == "forward_match"
      @records = Community.where("name LIKE ?", "#{@search_form}%")
    else
      @records = Community.all
    end
  end
  
  render 'search_results'
  end
  
   
 def genre_search
  @genre = Genre.find(params[:id])
  @communities = Community.where(genre_id: @genre.id)
  @genres = Genre.all
 end
  
  def community_search
    @word = params[:word]
    @model = params[:model]
    if @model == "community"
      @communites = Community.looks(params[:search], params[:word])
    end
  end
end