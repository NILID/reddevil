class RowsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :table
  load_and_authorize_resource :row, through: :table, except: %i[new_form]

  # TODO
  # Why not working?
  # after_action :find_last_redaction, only: [:index, :update]

  def new;  end
  def edit; end

  def get_miniform
    @attr = params[:attr]
    respond_to do |format|
      format.js
    end
  end

  def get_form
    @columnship = Columnship.where(id: params[:columnship]).first

    respond_to do |format|
      format.js
    end
  end

  def new_form
    @row = @table.rows.create(user_id: current_user.id)

    respond_to do |format|
      format.js
    end
  end

  def create
    @row.user = current_user

    respond_to do |format|
      if @row.save
        format.html { redirect_to @table, notice: t('flash.was_created', item: Row.model_name.human) }
        format.json { render json: @row, status: :created, location: @row }
      else
        format.html { render action: 'new' }
        format.json { render json: @row.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @row.update_attributes(row_params)
        format.html { redirect_to @table, notice: t('flash.was_updated', item: Row.model_name.human) }
        format.json { respond_with_bip(@row) }
        format.js
      else
        format.html { render action: 'edit' }
        format.json { respond_with_bip(@row) }
        format.js
      end
    end
  end

  def destroy
    @row.destroy

    respond_to do |format|
      format.html { redirect_to @table, notice: t('flash.was_destroyed', item: Row.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    def row_params
      list_params_allowed = [ :user_id,
                              { columnships_attributes: [:id, :column_id, :row_id, :data, :desc, :_destroy, :data => []] }
                            ]

      params.require(:row).permit(list_params_allowed)
    end
end
