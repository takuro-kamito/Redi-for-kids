class User::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
  @model = params[:model]
  @content = params[:content]
  @method = params[:method]

  if @model == 'User'
  @records = User.search_for(@content, @method)
  elsif @model == 'Community'
  @records = Community.search_for(@content, @method)
  elsif @model == 'Post_board'
  @records = PostBoard.search_for(@content, @method)
  end
render 'search_results'
  end

 def genre_search
  @genre = Genre.find(params[:id])
  @communities = Community.where(genre_id: @genre.id)
  @genres = Genre.order('created_at DESC').page(params[:page]).per(4)
 end

  def community_search
    @word = params[:word]
    @model = params[:model]
    if @model == "community"
      @communites = Community.looks(params[:search], params[:word])
    end
  end
end