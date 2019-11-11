class SubstratesController < ApplicationController
  load_and_authorize_resource

  def index
    @q = @substrates.includes(:user).ransack(params[:q])
    @substrates = @q.result(distinct: true).order(status: :desc, priority: :asc, created_at: :desc)
  end

  def show
    @subfiles = @substrate.subfiles.includes(:user).order(created_at: :desc)
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
                                        :wave, :corner, :frame, :priority, :drawing, :detail, :amount, :contract, :arrival_at,
                                        :arrival_from, :shipping_at, :shipping_to, :shipping_base,
                                        :status, :user_id,
                                        { subfiles_attributes: %i[id src user_id _destroy] }
                                        )
    end
end
