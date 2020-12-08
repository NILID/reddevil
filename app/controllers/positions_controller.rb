class PositionsController < ApplicationController
  load_and_authorize_resource :member
  load_and_authorize_resource :position, through: :member

  before_action :set_departments, only: %i[edit update new create]

  layout 'user'

  def index
    @positions = @positions.order(moved_at: :desc).includes(:department)
  end

  def new;   end
  def edit;  end

  def create
    respond_to do |format|
      if @position.save
        format.html { redirect_to [@member, Position], notice: t('flash.was_created', item: Position.model_name.human) }
        format.json { render :show, status: :created, location: @position }
      else
        format.html { render :new }
        format.json { render json: @position.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @position.update(position_params)
        format.html { redirect_to [@member, Position], notice: t('flash.was_updated', item: Position.model_name.human) }
        format.json { render :show, status: :ok, location: @position }
      else
        format.html { render :edit }
        format.json { render json: @position.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @position.destroy
    respond_to do |format|
      format.html { redirect_to [@member, Position], notice: t('flash.was_destroyed', item: Position.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    def set_departments
      @departments = Department.order(:title)
    end

    def position_params
      params.require(:position).permit(:position, :department_id, :member_id, :moved_at)
    end
end
