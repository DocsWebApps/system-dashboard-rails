class CommentsController < ApplicationController

  def new
    @comment=Comment.new
  end

  def create
    comment = Comment.new(comment_params)
    return_flash_hash=comment.save_new_comment
    redirect_to new_comment_path, return_flash_hash
  end

  private
    def comment_params
      params.require(:comment).permit(:comment)
    end
    
end