class PostsController < ApplicationController
  def new
   @post = Post.new
  end

  def create
   @post = Post.new(post_params)
   @post.user_id = current_user.id
   if @post.save
     redirect_to user_path(current_user.id), notice: 'You have created book successfully.'
   else
     render :new
   end
  end

  def show
   @post = Post.find(params[:id])
   @user = @post.user
   @comment = Comment.new
  end

  def index
   
  end

  def edit
   @post = Post.find(params[:id])
   @user = @post.user
  end

  def update
   @post = Post.find(params[:id])
   if @post.update(post_params)
    redirect_to post_path(@post.id), notice: '投稿の編集に成功しました'
   else
     render :edit
   end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_path(current_user.id), notice: '投稿を削除しました'
  end

  private

  def post_params
    params.require(:post).permit(:title,:text)
  end
end
