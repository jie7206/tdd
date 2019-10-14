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

  # 更新TDD步骤的值
  def update_tdd_step
    get_task_by_id
    new_step_num = params[:new_step_num].to_i
    if (1..$max_tdd_step_value).include? new_step_num
      #@task.update_attribute(:tdd_step, new_step_num)
      @task.set_tdd_step new_step_num
      flash[:info] = "任务(#{@task.id})的TDD步骤已更新至#{new_step_num}"
    end
    go_project_index
  end

  # 设为置顶任务
  def set_as_top_task
    update_top_to true, "已将任务设置为置顶任务"
  end

  # 取消置顶任务
  def cancel_top_task
    update_top_to false, "已将任务取消置顶"
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

    def update_top_to(new_value,info)
      get_task_by_id
      @task.update_attribute(:is_top, new_value)
      flash[:info] = info
      go_project_index
    end

end
