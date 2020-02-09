class TaskxController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  def create
    @taskx = current_user.taskxs.build(taskx_params)
    if @taskx.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @taskxs = current_user.taskxs.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'tasks/index'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  def task_params
    params.require(:task).permit(:content)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
    redirect_to root_url
    end
  end
end
