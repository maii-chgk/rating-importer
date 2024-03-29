# frozen_string_literal: true

require_relative '../strategies/temp_table'

class TournamentRostersImporter < TempTableStrategy
  def create_table(table_name)
    DB.create_table? table_name.to_sym do
      column :id, 'bigserial'
      Integer :tournament_id
      Integer :team_id
      Integer :player_id
      String :flag
      TrueClass :is_captain
      DateTime :updated_at
    end
  end

  def id_name
    :tournament_id
  end

  def main_table_name
    :tournament_rosters
  end
end
