# frozen_string_literal: true

class TutorialsController < ApplicationController
  before_action :user_authentication, only: :show

  def show
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end

  private

  def user_authentication
    if tutorial.classroom && !current_user
      flash.now[:error] = 'User must login to view classroom tutorials'
      render file: "#{Rails.root}/public/404.html", status: 404
    end
  end

  def tutorial
    tutorial ||= Tutorial.find(params[:id])
  end
end
