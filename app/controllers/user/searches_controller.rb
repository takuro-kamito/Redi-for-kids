class User::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
  @model = params[:model] #params[:model]`、`params[:content]`、`params[:method]`という変数に、検索フォームから送信された値が代入
  @content = params[:content]
  @method = params[:method]

  if @model == 'User'
  @records = User.search_for(@content, @method) #@model`の値に応じて、検索対象となるモデルのクラスメソッドを呼び出す。条件分岐を使って、`@model`が'user'の場合は`User`クラスの`search_for`メソッドを呼び出し、'community'の場合は`Community`クラスの`search_for`メソッドを呼び出し、'post_board'の場合は`PostBoard`クラスの`search_for`メソッドを呼び出す。
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
  @genres = Genre.all
  @communities = @genre.communities.order('created_at DESC').page(params[:page]).per(4) #@genreとcommunitesを紐付け検索結果に対してページネーション。
 end

end