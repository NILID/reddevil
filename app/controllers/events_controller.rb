class EventsController < ApplicationController
  load_and_authorize_resource only: [:list]
  load_and_authorize_resource :user, except: [:list]
  load_and_authorize_resource :event, through: :user, except: [:list]

  def list

  end

  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @event.save
        format.html { redirect_to [@user, @event], notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to [@user, @event], notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to [@user, Event] }
      format.json { head :no_content }
    end
  end
end
