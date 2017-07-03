class MachinesController < ApplicationController

  load_and_authorize_resource
  layout 'main'

  def index
    @machines = @machines.includes(:tasks => [:user])
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @machine.save
        format.html { redirect_to @machine, notice: 'Machine was successfully created.' }
        format.json { render json: @machine, status: :created, location: @machine }
      else
        format.html { render action: 'new' }
        format.json { render json: @machine.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @machine.update_attributes(params[:machine])
        format.html { redirect_to @machine, notice: 'Machine was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @machine.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @machine.destroy

    respond_to do |format|
      format.html { redirect_to machines_url }
      format.json { head :no_content }
    end
  end
end
