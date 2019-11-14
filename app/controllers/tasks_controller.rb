class TasksController < ApplicationController

  before_action :get_task_by_id, except: [:set_as_top_task, :cancel_top_task]

  # 编辑任务
  def edit
  end

  # 更新任务
  def update
    if @task.update_attributes(task_params)
      flash[:info] = "任务已更新成功！"
      go_projects_index
    else
      render action: :edit
    end
  end

  # 更新TDD步骤的值
  def update_tdd_step
    new_step_num = params[:new_step_num].to_i
    if (1..$max_tdd_step_value).include? new_step_num
      @task.set_tdd_step new_step_num
      flash[:info] = "任务(#{@task.id})的TDD步骤已更新至#{new_step_num}"
    end
    go_projects_index
  end

  # 设为置顶任务
  def set_as_top_task
    update_top_to true, "已将任务设置为置顶任务"
  end

  # 取消置顶任务
  def cancel_top_task
    update_top_to false, "已将任务取消置顶"
  end

  # 删除任务
  def destroy
    if @task.destroy
      flash[:info] = "任务已删除成功！"
      go_projects_index
    end
  end

  def name_up
    ids = Task.all.map {|t| t.id}
    id = @task.id
    name = @task.name
    pre_id = (id == ids[0]) ? id : ids[ids.index(id)-1]
    pre_task = Task.find(pre_id)
    @task.update_attribute(:name, pre_task.name)
    pre_task.update_attribute(:name, name)
    go_projects_index
  end

  def name_down
    ids = Task.all.map {|t| t.id}
    id = @task.id
    name = @task.name
    next_id = (id == ids[-1]) ? id : ids[ids.index(id)+1]
    next_task = Task.find(next_id)
    @task.update_attribute(:name, next_task.name)
    next_task.update_attribute(:name, name)
    go_projects_index
  end

  private

    # 供安全更新使用
    def task_params
      params.require(:task).permit(:name, :tdd_step, :note)
    end

    # 读取特定任务
    def get_task_by_id
      @task = Task.find(params[:id])
    end

    # 更新任务置顶的值
    def update_top_to(new_value, flash_info)
      get_task_by_id
      @task.update_attribute(:is_top, new_value)
      flash[:info] = flash_info
      go_projects_index
    end

end
