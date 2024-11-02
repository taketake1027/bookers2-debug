class BookCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @comment = @book.book_comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_back(fallback_location: book_path(@book), notice: "Comment was successfully created.")
    else
      redirect_back(fallback_location: book_path(@book), alert: "Unable to create comment.")
    end
  end

  def destroy
    @book = Book.find(params[:book_id]) # ここで本を見つける
    @comment = @book.book_comments.find(params[:id]) # 本に関連付けられたコメントを見つける

    if @comment.user == current_user
      @comment.destroy
      redirect_back(fallback_location: book_path(@book), notice: "Comment was successfully deleted.") # 本の詳細ページへリダイレクト
    else
      redirect_back(fallback_location: book_path(@book), alert: "You are not authorized to delete this comment.")
    end
  end

  private

  def comment_params
    params.require(:book_comment).permit(:body)
  end
end
