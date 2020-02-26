class MembersController < ApplicationController
  load_and_authorize_resource

  def index
    @q = @members.includes(:user).shown.ransack(params[:q])
    @q.group_eq = current_user.member.group if current_user.member && !params[:q] # TODO: check current_user and member
    @q.sorts = 'surname' if @q.sorts.empty?
    @members = @q.result(distinct: true)

    respond_to do |format|
      format.html
      format.json
      format.xls{ send_data @members.to_xls }
      format.pdf{ render pdf: 'Members' }
    end
  end

  def days_birth
    render json: @members.shown.group_by_day_of_week(:birth, format: "%A").count
  end

  def stat
    @q = @members.shown.ransack(params[:q])
    @q.group_eq = current_user.member.group if current_user.member && !params[:q] # TODO: check current_user and member
    @members = @q.result(distinct: true)

    @member_ages = []
    @members.with_birth.each {|m| @member_ages << m.age}

    members_birth_months = []
    @members.with_birth.each {|m| members_birth_months << m.birth.strftime('%m')}
    @members_birth_months = (members_birth_months.inject(Hash.new(0)) {|h,e| h[e] +=1 ; h}).sort_by{|_key, value| value}.reverse!.slice(0, 3)

    members_birth_days = []
    @members.with_birth.each {|m| members_birth_days << m.birth.strftime('%w')}
    @members_birth_days = (members_birth_days.inject(Hash.new(0)) {|h,e| h[e] +=1 ; h}).sort_by{|_key, value| value}.reverse!.slice(0, 3)
  end

  def archive
    @q = @members.archive.ransack(params[:q])
    @q.sorts = 'surname' if @q.sorts.empty?
    @members = @q.result(distinct: true)
  end

  def new; end

  def manage_holidays; end
  def edit; end

  def create
    respond_to do |format|
      if @member.save
        format.html { redirect_to members_url, notice: t('flash.was_created', item: Member.model_name.human) }
        format.json { render json: @member, status: :created, location: @member }
      else
        format.html { render action: 'new' }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @member.update_attributes(member_params)
        format.html { redirect_to members_url, notice: t('flash.was_updated', item: Member.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_holidays
    respond_to do |format|
      if @member.update_attributes(member_params)
        format.html { redirect_to manage_holidays_member_url(@member), notice: t('flash.was_updated', item: t('member.vacation').downcase) }
        format.json { head :no_content }
      else
        format.html { render action: 'manage_holidays' }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_sickdays
    respond_to do |format|
      if @member.update_attributes(member_params)
        format.html { redirect_to manage_sickdays_member_url(@member), notice: t('vacations.sick_was_updated') }
        format.json { head :no_content }
      else
        format.html { render action: 'manage_sickdays' }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @member.destroy

    respond_to do |format|
      format.html { redirect_to members_url, notice: t('flash.was_destroyed', item: Member.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    def member_params
      list_params_allowed = [:surname,
                             :name,
                             :patronymic,
                             :work_phone,
                             :phone,
                             :position,
                             :short_number,
                             :email,
                             :birth,
                             { vacations_attributes: %i[id flag startdate enddate _destroy] }
                            ]
      list_params_allowed << [:archive_flag, :user_id, :group] if (current_user&.role? :admin)
      params.require(:member).permit(list_params_allowed)
    end
end
