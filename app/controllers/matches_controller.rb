class MatchesController < ApplicationController
  load_and_authorize_resource :round
  load_and_authorize_resource :match, through: :round

  layout 'withside'

  def get_results
    @results = (Match.where(team1_id: [@match.team1, @match.team2], team2_id: [@match.team1, @match.team2])
                    .joins(:round)
                    .where(rounds: { type_id: @round.type_id }) - [@match])
  end

  def destroy
    @match.destroy

    respond_to do |format|
      format.html { redirect_to [@round, Match], notice: t('flash.was_destroyed', item: Match.model_name.human) }
      format.json { head :no_content }
    end
  end
end
