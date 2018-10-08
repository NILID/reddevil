class TasksController < ApplicationController
  load_and_authorize_resource :machine
  load_and_authorize_resource :task, through: :machine

  layout 'main'

  def index; end
  def show;  end
  def new;   end
  def edit;  end

  def create
    @task.user = current_user

    respond_to do |format|
      if @task.save
        format.html { redirect_to machines_url, notice: t('flash.was_created', item: Task.model_name.human) }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    old_end_time = @task.end_time

    respond_to do |format|
      if @task.update_attributes(task_params)
        @task.update_next_tasks(old_end_time) if params[:task][:update_tasks_flag] == '1'

        format.html { redirect_to machines_url, notice: t('flash.was_updated', item: Task.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to machines_url, notice: t('flash.was_destroyed', item: Task.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    def task_params
      list_params_allowed = %i[complete end_time start_time title update_tasks_flag]
      params.require(:task).permit(list_params_allowed)
    end
end
