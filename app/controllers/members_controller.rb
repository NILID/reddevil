class MembersController < ApplicationController
  load_and_authorize_resource
  before_action :set_departments, only: %i[index stat edit update new create archive]

  layout 'user'

  def index
    @q = @members.shown.ransack(params[:q])
    @q.sorts = 'surname' if @q.sorts.empty?
    @members = @q.result(distinct: true)
    @members_orphans = @members.select{ |m| m if m.department_id == nil}

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
    @q.department_id_eq = current_user.member.department_id if current_user.member && !params[:q] # TODO: check current_user and member
    @members = @q.result(distinct: true)

    @members_with_birth = @members.with_birth

    @member_ages = @members_with_birth.collect {|m| m.age}

    members_birth_months = @members_with_birth.collect {|m| [m.birth.strftime('%m'), m.birth.strftime('%w')]}
                                              .transpose
    @members_birth_months = members_birth_months[0]
                                                .inject(Hash.new(0)) {|h,e| h[e] +=1 ; h}
                                                .sort_by{|_key, value| value}
                                                .last(3)
                                                .reverse

    @members_birth_days   = members_birth_months[1]
                                                .inject(Hash.new(0)) {|h,e| h[e] +=1 ; h}
                                                .sort_by{|_key, value| value}
                                                .last(3)
                                                .reverse
  end

  def archive
    @q = @members.archive.ransack(params[:q])
    @q.sorts = 'surname' if @q.sorts.empty?
    @members = @q.result(distinct: true)
  end

  def new; end

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

  def toggle_remote
    if @member.toggle!(:remote_flag)
      flash[:success] = t('flash.was_updated', item: Member.model_name.human)
      redirect_to members_url
    else
      render :edit
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
    def set_departments
      @departments = Department.order(:title)
    end

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
                             :hide_year
                            ]
      list_params_allowed << [:archive_flag, :user_id, :toggle_flag, :department_id] if (current_user&.role? :admin)
      params.require(:member).permit(list_params_allowed)
    end
end
