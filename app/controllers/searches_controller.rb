class SearchesController < ApplicationController
  def search
    # フォームから送信されたキーワードを@queryに代入
    @query = params[:query]

    # ユーザーか投稿を指定するプルダウンからの情報を@targetに代入
    @target = params[:target]

    # 選択された検索対象に応じて検索処理を分ける
    if @target == 'User'
      # Userモデルからnameがキーワードに一致するユーザーを検索
      @results = User.where('name LIKE ?', "%#{@query}%")
    elsif @target == 'Book'
      # Postモデルからtitleまたはbodyがキーワードに一致する投稿を検索
      @results = Book.where('title LIKE ? OR body LIKE ?', "%#{@query}%", "%#{@query}%")
    else
      # 該当しない場合、空の結果を設定
      @results = []
    end
  end
end
