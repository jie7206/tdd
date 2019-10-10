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
  end

  private

    def task_params
      params.require(:task).permit(:name)
    end

end
