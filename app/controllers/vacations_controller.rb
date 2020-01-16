class VacationsController < ApplicationController
  load_and_authorize_resource
  layout 'withside'

  def index; end
end
