class TasksController < ApplicationController
  load_and_authorize_resource :machine
  load_and_authorize_resource :task, through: :machine

  layout 'main'

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @task.user = current_user

    respond_to do |format|
      if @task.save
        format.html { redirect_to machines_url, notice: t('tasks.was_created') }
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
      if @task.update_attributes(params[:task])
        @task.update_next_tasks(old_end_time) if params[:task][:update_tasks_flag] == '1'

        format.html { redirect_to machines_url, notice: t('tasks.was_updated') }
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
      format.html { redirect_to machines_url }
      format.json { head :no_content }
    end
  end
end
