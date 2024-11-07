class EventMailer < ApplicationMailer
  default from: 'no-reply@yourdomain.com'  # 送信元メールアドレスを適切に設定してください

  def send_event_notification(user, title, body)
    @user = user
    @title = title
    @body = body
    mail(to: @user.email, subject: @title) do |format|
      format.text { render plain: @body }
      format.html { render html: @body.html_safe }
    end
  end
end
