class MembersController < ApplicationController
  load_and_authorize_resource
  layout 'main'

  def index
    @q = @members.search(params[:q])
    @q.sorts = 'surname' if @q.sorts.empty?
    @members = @q.result(distinct: true)
    @members_all = Member.all
    @member_ages = []
    @members_all.each {|m| @member_ages << m.age}

    members_birth_months=[]
    @members_all.each {|m| members_birth_months << m.birth.strftime("%m")}
    @members_birth_months = (members_birth_months.inject(Hash.new(0)) {|h,e| h[e] +=1 ; h}).sort_by{|_key, value| value}.reverse!.slice(0, 3)

    members_birth_days=[]
    @members_all.each {|m| members_birth_days << m.birth.strftime("%w")}
    @members_birth_days = (
    members_birth_days.inject(Hash.new(0)) {|h,e| h[e] +=1 ; h}).sort_by{|_key, value| value}.reverse!.slice(0, 3)
    respond_to do |format|
      format.html
      format.json
      format.xls{ send_data @members.to_xls }
      format.pdf{ render pdf: 'Members' }
    end
  end

  def new
  end

  def edit
  end

  def create
    respond_to do |format|
      if @member.save
        format.html { redirect_to members_url, notice: 'Member was successfully created.' }
        format.json { render json: @member, status: :created, location: @member }
      else
        format.html { render action: "new" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @member.update_attributes(params[:member])
        format.html { redirect_to members_url, notice: 'Member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @member.destroy

    respond_to do |format|
      format.html { redirect_to members_url }
      format.json { head :no_content }
    end
  end
end
