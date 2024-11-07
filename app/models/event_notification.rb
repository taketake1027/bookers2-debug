class EventNotification
  include ActiveModel::Model

  attr_accessor :title, :body

  validates :title, presence: true
  validates :body, presence: true
end
