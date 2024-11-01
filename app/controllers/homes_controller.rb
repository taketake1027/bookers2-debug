class HomesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:top, :about]
end
