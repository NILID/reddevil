class ItemsController < ApplicationController
  load_and_authorize_resource

  def create
    respond_to do |format|
      if @item.save
        format.html { redirect_to controller: 'main', action: 'mirror', m: @item.id }
      else
        format.html { redirect_to mirror_url }
      end
    end
  end

  private
    def item_params
      list_params_allowed = %i[file]
      params.require(:item).permit(list_params_allowed)
    end
end
