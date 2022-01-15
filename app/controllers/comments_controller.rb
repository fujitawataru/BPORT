class CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id
   if comment.save
      @post = comment.post #エラーのため追加
      @post.create_notification_comment!(current_user, comment.id) #通知レコード作成、エラーのため@comment.idをcomment.idに変更
      redirect_to post_path(post), notice: 'コメントが完了しました'
    else
      render :show
    end
  end

  def destroy
     Comment.find_by(id: params[:id]).destroy
     redirect_to post_path(params[:post_id]), notice: 'コメントを削除しました'
  end

   private

  def comment_params
    params.require(:comment).permit(:comment)
  end
  
end
