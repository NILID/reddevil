class PositionsController < ApplicationController
  load_and_authorize_resource only: [:career]

  load_and_authorize_resource :member, except: [:career]
  load_and_authorize_resource :position, through: :member, except: [:career]

  before_action :set_departments, only: %i[edit update new create]

  layout 'user_with_side'

  def index
    @positions = @positions.order(moved_at: :desc).includes(:department)
  end

  def career
    @q = @positions.ransack(params[:q])

    @positions = @q.result(distinct: true)
                   .includes(:member, :department)
                   .order(moved_at: :desc)

    @members = (@positions.includes(:member, :department).collect {|p| p.member}).uniq

    if !params[:q]
      redirect_to career_positions_path(q: { moved_at_gteq: Russian.strftime(DateTime.now.beginning_of_month, '%d.%m.%Y'),
                                             moved_at_lteq: Russian.strftime(DateTime.now.end_of_month,       '%d.%m.%Y') })
    end
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
