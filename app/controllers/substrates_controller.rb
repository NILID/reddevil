class SubstratesController < ApplicationController
  load_and_authorize_resource

  def index
    @substrates = @substrates.includes(:substrate_features).not_archive
    get_ransack

    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def archive
    @substrates = @substrates.includes(:substrate_features).archive
    get_ransack
    render 'index'
  end

  def search
    @substrates = @substrates.includes(:substrate_features)
    get_ransack
    render 'index'
  end

  def history
    @versions = PaperTrail::Version.where(item_type: 'Substrate').includes(:item).order(created_at: :desc).paginate(page: params[:page], per_page: 20)
  end

  def changes
    @versions = @substrate.versions.reorder(created_at: :desc).paginate(page: params[:page], per_page: 20)
    render 'history'
  end

  def copy
    substrate = @substrate.deep_clone include: %i[substrate_features users]
    substrate.title   = substrate.title   + ' (копия)'
    substrate.drawing = substrate.drawing + ' (копия)'

    respond_to do |format|
      if substrate.save
        format.html { redirect_to substrates_url, notice: t('flash.was_cloned', item: Substrate.model_name.human) }
      else
        format.html { redirect_to substrates_url, error: 'Duplicate failed' }
      end
    end
  end

  def show
    @subfiles = @substrate.subfiles.includes(:user).order(created_at: :desc)
    @followers = @substrate.users.includes(:member).order('members.surname')
    @users = User.with_group(:lab182).includes(:member).order('members.surname') - @followers
    substrate_features = @substrate.substrate_features
    @substrate_features_a = substrate_features.select { |s| s.wave == 'A' }
    @substrate_features_b = substrate_features.select { |s| s.wave == 'B' }
    @otk_documents= @substrate.otk_documents.includes(:blob)

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

  def delete_document
    @document = ActiveStorage::Blob.find_signed(params[:document_id])
    # Check valid method to destroy attachment
    @document.attachments.first.purge

    redirect_to @substrate
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
    def get_ransack
      @q = @substrates.ransack(params[:q])
      # with pagination
      # @substrates = @q.result(distinct: true).includes(:user).order(:statuses_mask, priorityx: :asc, created_at: :desc).page(params[:page]).per_page(10)
      @substrates = @q.result(distinct: true).includes(:user).order(:statuses_mask, priorityx: :asc, created_at: :desc)
      @users = User.with_group(:lab182).includes(:member).order('members.surname')
    end

    def substrate_params
      # params.require(:substrate).permit(:lock_version,
      substrate_params = [:title, :ready_count,
                          :desc, :coating_type, :coating_type_b, :sides,
                          :corner, :corner_b, :frame, :priorityx, :drawing,
                          :detail, :amount, :contract, :instock,
                          :arrival_at, :arrival_from, :shipping_at, :shipping_to, :shipping_base,
                          :status, :user_id, :future_shipping_at, :rad_strength, :shape,
                          :width, :height, :thickness, :diameter,
                          { subfiles_attributes: %i[id src user_id _destroy] },
                          { substrate_features_a_attributes: %i[id length sign litera feature _destroy] },
                          { substrate_features_b_attributes: %i[id length sign litera feature _destroy] }
                         ]

      substrate_params << [:otk_status, :otk_desc, otk_documents: []] if (current_user&.role? :admin) || (current_user&.has_group? :otk)

      params.require(:substrate).permit(substrate_params)
    end
end
