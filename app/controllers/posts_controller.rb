class PostsController < ApplicationController
  before_action :require_login, :only => [:create, :new]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(title: params[:post][:title],
                     content: params[:post][:content],
                     author: current_user.id)
    if @post.save
      redirect_to '/posts'
    else
      redirect_to  '/posts'
    end

  end

  def index
    @posts = Post.all
  end


end
