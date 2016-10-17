class MembersController < ApplicationController
  load_and_authorize_resource

  def index
    @q = @members.search(params[:q])
    @q.sorts = 'surname' if @q.sorts.empty?
    @members = @q.result(distinct: true)
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
