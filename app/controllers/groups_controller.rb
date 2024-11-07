class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :notice_an_event, :send_event_notification, :send_event_complete]

  def index
    @groups = Group.all
    @book = Book.new
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner = current_user
    if @group.save
      redirect_to groups_path, notice: 'グループが作成されました'
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
    @book = Book.new
    # GroupとBookが関連している場合、以下のように記述します
    @books = Book.where(group_id: @group.id)
  end

  def edit
    @group = Group.find(params[:id])
    redirect_to groups_path, alert: '権限がありません。' unless @group.owner == current_user
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path, notice: 'グループが更新されました'
    else
      render :edit
    end
  end

  def join
    @group = Group.find(params[:id])
    unless @group.members.include?(current_user)
      @group.members << current_user
      redirect_to group_path(@group), notice: 'グループに参加しました。'
    else
      redirect_to group_path(@group), alert: 'すでに参加しています。'
    end
  end

  def leave
    @group = Group.find(params[:id])
    if @group.members.include?(current_user)
      @group.members.delete(current_user)
      redirect_to group_path(@group), notice: 'グループから退会しました。'
    else
      redirect_to group_path(@group), alert: 'このグループに参加していません。'
    end
  end

  def notice_an_event
    @event_notification = EventNotification.new
  end

  def send_event_notification
    @event_notification = EventNotification.new(event_notification_params)
    if @event_notification.valid?
      # メンバー全員にメールを送信
      @group.members.each do |member|
        EventMailer.send_event_notification(member, @event_notification.title, @event_notification.body).deliver_later
      end
      flash[:notice] = "送信が完了しました"
      # 送信完了ページにリダイレクト
      redirect_to send_event_complete_group_path(@group, title: @event_notification.title, body: @event_notification.body)
    else
      flash[:alert] = "メールの送信に失敗しました"
      render :notice_an_event
    end
  end

  # 送信完了後のページ
  def send_event_complete
    @title = params[:title]
    @body = params[:body]
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image, :description)
  end

  def set_group
    @group = Group.find(params[:id])
  end

  def event_notification_params
    params.require(:event_notification).permit(:title, :body)
  end
end
