class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    if favorite.save
      redirect_back(fallback_location: root_path, notice: "You liked the book.")
    else
      redirect_back(fallback_location: root_path, alert: "Unable to like the book.")
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    if favorite&.destroy
      redirect_back(fallback_location: root_path, notice: "You unliked the book.")
    else
      redirect_back(fallback_location: root_path, alert: "Unable to unlike the book")
    end
  end
end
