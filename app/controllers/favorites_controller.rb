class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book

  def create
    @favorite = current_user.favorites.new(book_id: @book.id)
    respond_to do |format|
      if @favorite.save
        format.html { redirect_back(fallback_location: root_path, notice: "You liked the book.") }
        format.js   # JSリクエストに対応
      else
        format.html { redirect_back(fallback_location: root_path, alert: "Unable to like the book.") }
      end
    end
  end

  def destroy
    @favorite = current_user.favorites.find_by(book_id: @book.id)
    respond_to do |format|
      if @favorite&.destroy
        format.html { redirect_back(fallback_location: root_path, notice: "You unliked the book.") }
        format.js   # JSリクエストに対応
      else
        format.html { redirect_back(fallback_location: root_path, alert: "Unable to unlike the book") }
      end
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end
end
