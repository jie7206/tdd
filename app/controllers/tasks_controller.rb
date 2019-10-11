class TasksController < ApplicationController

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      redirect_to projects_path
    else
      render action: :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      flash[:info] = "任务已删除成功！"
      redirect_to projects_path
    end
  end

  private

    def task_params
      params.require(:task).permit(:name)
    end

end
