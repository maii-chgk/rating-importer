# frozen_string_literal: true

require_relative '../strategies/temp_table'

class BaseRostersImporter < TempTableStrategy
  def create_table(table_name)
    DB.create_table? table_name.to_sym do
      column :id, 'bigserial'
      Integer :team_id
      Integer :player_id
      Integer :season_id
      Date :start_date
      Date :end_date
      DateTime :updated_at
    end
  end

  def id_name
    :team_id
  end

  def main_table_name
    :base_rosters
  end

  def self.delete_rosters_for(team_ids:)
    DB[:base_rosters].where(team_id: team_ids).delete
  end
end
