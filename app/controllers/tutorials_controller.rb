# frozen_string_literal: true

class TutorialsController < ApplicationController
  before_action :user_authentication, only: :show

  def show
    tutorial = Tutorial.find(params[:id])
    @facade = TutorialFacade.new(tutorial, params[:video_id])
  end

  private

  def user_authentication
    unless current_user
      flash.now[:notice] = 'User must login to bookmark videos'
    end
  end
end
