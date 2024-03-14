class PostsController < ApplicationController
  
  def posts
  @post = Post.find(params[:id])
  end
end 
