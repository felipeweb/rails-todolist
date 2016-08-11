class TasksController < ApplicationController
  def create
    task = Task.new(task_params)

    if task.save
      render json: { name: task.name, url: list_task_path(task.list_id, task.id) }
    else
      render json: { errors: task.errors.full_messages }, status: 422
    end
  end

  def update
    task = Task.find(task_id)

    task.update_attributes(update_task_params)

    render json: { name: task.name }
  end

  def show
    @task = Task.find(task_id)
    @subtasks = @task.subtasks.where(father_subtask_id: nil)
  end

  private

  def update_task_params
    params.permit(:done)
  end

  def task_id
    params[:id]
  end

  def task_params
    params.permit(:list_id, :name)
  end

end