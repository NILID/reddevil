class HolidaysController < ApplicationController
  before_filter :authenticate_user!

  load_and_authorize_resource only: [:list]
  load_and_authorize_resource :member, except: [:list]
  load_and_authorize_resource :holiday, through: :member, except: [:list]

  def list
    @holidays = @holidays.order(:start)
  end

  def index
    @holidays = @holidays.order(:start)
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @holiday.save
        format.html { redirect_to [@member, Holiday], notice: 'Holiday was successfully created.' }
        format.json { render json: @holiday, status: :created, location: @holiday }
      else
        format.html { render action: 'new' }
        format.json { render json: @holiday.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @holiday.update_attributes(params[:holiday])
        format.html { redirect_to [@member, Holiday], notice: 'Holiday was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @holiday.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @holiday.destroy

    respond_to do |format|
      format.html { redirect_to [@member, Holiday] }
      format.json { head :no_content }
    end
  end
end
