require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded any time
  # it changes. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true  # エラー発生時にエラーを表示する

  # Use Gmail SMTP settings to send mail
  config.action_mailer.smtp_settings = {
    address:              'smtp.gmail.com',    # GmailのSMTPサーバー
    port:                 587,                 # SMTPポート
    domain:               'gmail.com',         # ドメイン
    user_name:            ENV['GMAIL_USERNAME'],  # Gmailのユーザー名 (環境変数)
    password:             ENV['GMAIL_PASSWORD'],  # Gmailのパスワード (環境変数)
    authentication:       'plain',             # 認証方法
    enable_starttls_auto: true,                # TLS/SSLを有効化
    open_timeout:         5,                   # 接続タイムアウト (秒)
    read_timeout:         5                    # 読み取りタイムアウト (秒)
  }

  # メール送信のURL設定（ローカルホスト用）
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  # メール送信時にエラーが発生した場合にエラーを表示する
  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Debug mode disables concatenation and preprocessing of assets.
  config.assets.debug = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Allow all hosts (for development environment).
  config.hosts.clear

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true
end
