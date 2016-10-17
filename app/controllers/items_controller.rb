class ItemsController < ApplicationController
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        format.html { redirect_to controller: 'main', action: 'mirror', m: @item.id }
      else
        format.html { redirect_to mirror_url }
      end
    end
  end
end
