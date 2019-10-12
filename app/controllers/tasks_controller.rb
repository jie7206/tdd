class TasksController < ApplicationController

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:info] = "任务已更新成功！"
      redirect_to projects_path
    else
      #flash.now[:warning] = @task.errors
      render action: :edit
    end
  end

  def update_tdd_step
    @task = Task.find(params[:id])
    new_step_num = params[:new_step_num].to_i
    if (1..$tdd_steps_array.size).include? new_step_num
      @task.update_attribute(:tdd_step, new_step_num)
      flash[:info] = "任务No.#{@task.id}的TDD步骤已更新至#{new_step_num}"
    end
    redirect_to projects_path
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
      params.require(:task).permit(:name, :tdd_step)
    end

end
