class TasksController < ApplicationController

  def edit
    get_task_by_id
  end

  def update
    get_task_by_id
    if @task.update_attributes(task_params)
      flash[:info] = "任务已更新成功！"
      go_project_index
    else
      render action: :edit
    end
  end

  def update_tdd_step
    get_task_by_id
    new_step_num = params[:new_step_num].to_i
    if (1..$tdd_steps_array.size).include? new_step_num
      @task.update_attribute(:tdd_step, new_step_num)
      flash[:info] = "任务No.#{@task.id}的TDD步骤已更新至#{new_step_num}"
    end
    go_project_index
  end

  def destroy
    get_task_by_id
    if @task.destroy
      flash[:info] = "任务已删除成功！"
      go_project_index
    end
  end

  private

    def task_params
      params.require(:task).permit(:name, :tdd_step)
    end

    def get_task_by_id
      @task = Task.find(params[:id])
    end

end
