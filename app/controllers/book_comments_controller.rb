class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book

  def create
    @comment = @book.book_comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @book, notice: "Comment was successfully created." }
        format.js   # AJAXリクエストに対応
      else
        format.html { redirect_to @book, alert: "Unable to create comment." }
      end
    end
  end

  def destroy
    @comment = @book.book_comments.find(params[:id]) # 本に関連付けられたコメントを見つける

    if @comment.user == current_user
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to @book, notice: "Comment was successfully deleted." }
        format.js   # AJAXリクエストに対応
      end
    else
      redirect_back(fallback_location: book_path(@book), alert: "You are not authorized to delete this comment.")
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def comment_params
    params.require(:book_comment).permit(:body)
  end
end
