class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @books = @user.books.includes(:book_comments)
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    # @userはbefore_actionで設定されているため、ここでは何もしなくて大丈夫です。
  end

  def update
    if @user.update(user_params)  # ensure_correct_userで@userが設定されているので、ここで再度取得する必要はありません
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def set_user
    @user = User.find(params[:id])  # ユーザー情報を取得するメソッド
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    unless @user == current_user
      redirect_to user_path(current_user), alert: "You are not authorized to edit this user."  # 自分のユーザー詳細ページにリダイレクト
    end
  end
end
