class UsersController < ApplicationController
  load_and_authorize_resource

  before_action :set_departments, only: [:edit, :update]

  layout 'user'

  def index
    @q = @users.includes(:profile, :member).ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def show
    now     = DateTime.now.beginning_of_day
    @member = @user.member
    @users  = (User.all - [current_user]).sample(6)
    @online_users = User.online
    if @member
      @current_vacations_soon = @member.vacations
        .where('startdate >= ?', now)
        .where(flag: 'rest')
        .order(:startdate).first
      @current_vacation       = @member.vacations
        .where('startdate <= ?', now)
        .where('enddate >= ?',   now)
        .where(flag: 'rest')
        .first
    end
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      # if params[:profile][:avatar].present?
      #    render :crop
      # else
      redirect_to @user, notice: t('flash.was_updated', item: User.model_name.human)
      # end
    else
      render :edit
    end
  end

  def make_role
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to @user, notice: t('flash.was_updated', item: User.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def user_params
      profile_params = %i[avatar crop_x crop_y crop_w crop_h background_color total_result id]
      member_params  = %i[position surname name patronymic work_phone phone short_number email birth id hide_year]
      member_params << %i[archive_flag user_id department_id] if (current_user&.role? :admin)

      list_params_allowed = [ { profile_attributes: profile_params }, { member_attributes:  member_params } ]
      list_params_allowed << [:roles_mask, :sport_flag, roles: [], groups: []] if (current_user&.role? :admin)

      params.require(:user).permit(list_params_allowed)
    end

    def set_departments
      @departments = Department.order(:title).includes(:members)
    end
end