class SubstratesController < ApplicationController
  load_and_authorize_resource

  def index
    @q = @substrates.includes(:user).ransack(params[:q])
    @substrates = @q.result(distinct: true).order(:statuses_mask, priority: :asc, created_at: :desc)
  end

  def copy
    substrate = Substrate.new
    substrate = @substrate.dup
    substrate.title = substrate.title + ' (копия)'
    respond_to do |format|
      if substrate.save
        format.html { redirect_to substrates_url, notice: t('flash.was_created', item: Substrate.model_name.human) }
      else
        format.html { redirect_to substrates_url, error: 'Dubplicate failed' }
      end
    end

  end

  def show
    @subfiles = @substrate.subfiles.includes(:user).order(created_at: :desc)
    @users = User.with_group(:lab182) - @substrate.followers(User)
  end

  def follow
    @user = User.where(id: params[:user_id]).first
    if @user
      @user.toggle_follow!(@substrate)
      respond_to :js
    end
  end

  def new;   end
  def edit;  end

  def create
    @substrate.user = current_user

    respond_to do |format|
      if @substrate.save
        format.html { redirect_to @substrate, notice: t('flash.was_created', item: Substrate.model_name.human) }
        format.json { render :show, status: :created, location: @substrate }
      else
        format.html { render :new }
        format.json { render json: @substrate.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @substrate.update(substrate_params)
        if substrate_params[:subfiles]
          substrate_params[:subfiles].each { |s| @substrate.subfiles.create(src: s)}
        end
        format.html { redirect_to @substrate, notice: t('flash.was_updated', item: Substrate.model_name.human) }
        format.json { render :show, status: :ok, location: @substrate }
      else
        format.html { render :edit }
        format.json { render json: @substrate.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @substrate.destroy
    respond_to do |format|
      format.html { redirect_to substrates_url, notice: t('flash.was_destroyed', item: Substrate.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    def substrate_params
      params.require(:substrate).permit(:title,
                                        :desc, :coating_type,
                                        :wave, :corner, :frame, :priority, :drawing, :detail, :amount, :contract, :propotions,
                                        :arrival_at, :arrival_from, :shipping_at, :shipping_to, :shipping_base,
                                        :status, :user_id,
                                        { subfiles_attributes: %i[id src user_id _destroy] }
                                        )
    end
end
