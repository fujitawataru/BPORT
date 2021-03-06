class PostsController < ApplicationController
  def new
   @post = Post.new
  end

  def create
   @post = Post.new(post_params)
   @post.user_id = current_user.id
   if @post.save
     redirect_to user_path(current_user.id), notice: '投稿が完了しました'
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
   @posts = Post.limit(10).order(" created_at DESC ")
   @tags = Post.tag_counts_on(:tags).order('count DESC')     # 全タグ(Postモデルからtagsカラムを降順で取得)
   if @tag = params[:tag]   # タグ検索用
    @post = Post.tagged_with(params[:tag])   # タグに紐付く投稿
   end
  end

  def search
   @post = Post.search(params[:keyword]) #「〇〇件の該当がありました」用に追加
   @posts = Post.search(params[:keyword]).page(params[:page]).per(10)
   @keyword = params[:keyword]
   @tags = Post.tag_counts_on(:tags).order('count DESC') #この記述がないとrender時にエラーのため追加
   render "search"
  end

  def edit
   @post = Post.find(params[:id])
   @user = @post.user
   redirect_to user_path(current_user) unless current_user.id == @post.user_id
  end

  def update
   @post = Post.find(params[:id])
   if @post.update(post_params)
    redirect_to post_path(@post.id), notice: '投稿の編集が完了しました'
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
    params.require(:post).permit(:title,:text,:tag_list)
  end
end
