class SubstratesController < ApplicationController
  load_and_authorize_resource

  def index
    @q = @substrates.not_archive.ransack(params[:q])
    @substrates = @q.result(distinct: true).includes(:user).order(:statuses_mask, priorityx: :asc, created_at: :desc)
    @users = User.with_group(:lab182).includes(:member).order('members.surname')
  end

  def archive
    @q = @substrates.archive.ransack(params[:q])
    @substrates = @q.result(distinct: true).includes(:user).order(:statuses_mask, priorityx: :asc, created_at: :desc)
    @users = User.with_group(:lab182).includes(:member).order('members.surname')
    render 'index'
  end

  def history
    @versions = PaperTrail::Version.where(item_type: 'Substrate').includes(:item).order('created_at DESC')
  end

  def changes
    @versions = @substrate.versions.reverse
    render 'history'
  end

  def copy
    substrate = @substrate.dup
    substrate.title = substrate.title + ' (копия)'
    substrate.drawing = ''

    respond_to do |format|
      if substrate.save
        format.html { redirect_to substrates_url, notice: t('flash.was_created', item: Substrate.model_name.human) }
      else
        format.html { redirect_to substrates_url, error: 'Duplicate failed' }
      end
    end
  end

  def show
    @subfiles = @substrate.subfiles.includes(:user).order(created_at: :desc)
    @followers = @substrate.users.includes(:member).order('members.surname')
    @users = User.with_group(:lab182).includes(:member).order('members.surname') - @followers

    respond_to do |format|
      format.html
      format.js
    end
  end

  def follow
    @user = User.where(id: params[:user_id]).first
    if @user
      if @substrate.user_ids.include? @user.id
        @substrate.users.delete(@user)
      else
        @substrate.users << @user
      end
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

  protected
  #  def correct_stale_record_version
  #    @substrate.reload.attributes = substrate_params.reject do |attr, value|
  #      attr.to_sym == :lock_version
  #    end
  #  end

  private
    def substrate_params
      # params.require(:substrate).permit(:lock_version,
      params.require(:substrate).permit(:title, :ready_count,
                                        :desc, :coating_type, :coating_type_b, :sides,
                                        :wave, :wave_b, :corner, :corner_b, :frame, :priorityx, :drawing,
                                        :detail, :amount, :contract, :propotions, :instock,
                                        :arrival_at, :arrival_from, :shipping_at, :shipping_to, :shipping_base,
                                        :status, :user_id, :future_shipping_at,
                                        { subfiles_attributes: %i[id src user_id _destroy] }
                                        )
    end
end
