class TablesController < ApplicationController
  load_and_authorize_resource

  def index; end
  def show
    @q = @table.rows.ransack(params[:q])
    @rows = @q.result.includes(columnships: %i[column])
    @last_redaction = @rows.order('updated_at desc').first
  end
  def new;   end
  def edit;  end

  def create
    respond_to do |format|
      if @table.save
        format.html { redirect_to @table, notice: t('flash.was_created', item: Table.model_name.human) }
        format.json { render json: @table, status: :created, location: @table }
      else
        format.html { render action: 'new' }
        format.json { render json: @table.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @table.update_attributes(table_params)
        format.html { redirect_to @table, notice: t('flash.was_updated', item: Table.model_name.human) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @table.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @table.destroy

    respond_to do |format|
      format.html { redirect_to tables_url, notice: t('flash.was_destroyed', item: Table.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    def table_params
      params.require(:table).permit(:title, :category, columns_attributes: %i[id name column_type _destroy])
    end
end
