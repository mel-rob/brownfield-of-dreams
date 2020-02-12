class EmailConfirmationController < ApplicationController
  def edit
    user = User.find(params[:id])
    user.update(active?: true)
    flash[:notice] = 'Thank you! Your account is now activated.'
    redirect_to dashboard_path
  end
end
