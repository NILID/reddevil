class YearsController < ApplicationController
  load_and_authorize_resource find_by: :slug
  layout 'withside'

  def index; end
  def show;  end
  def new;   end
  def edit;  end

  def create
    respond_to do |format|
      if @year.save
        format.html { redirect_to [@year, Purchase], notice: t('flash.was_created', item: Year.model_name.human) }
        format.json { render json: @year, status: :created, location: @year }
      else
        format.html { render action: 'new' }
        format.json { render json: @year.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @year.update_attributes(params[:year])
        format.html { redirect_to [@year, Purchase], notice: t('flash.was_updated', item: Year.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @year.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @year.destroy

    respond_to do |format|
      format.html { redirect_to years_url, notice: t('flash.was_destroyed', item: Year.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    def year_params
      list_params_allowed = [
                              :year,
                              { :columns_attributes => %i[id name column_type _destroy] }
                            ]
      params.require(:year).permit(list_params_allowed)
    end
end
