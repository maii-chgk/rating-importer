# frozen_string_literal: true

require 'httparty'

require_relative '../db'
require_relative '../api/client'

class SeasonsImporter
  def initialize
    @api_client = APIClient.new
  end

  def run
    @seasons = fetch_data
    create_table
    truncate_table
    insert_data
  end

  def fetch_data
    @api_client.seasons.map { |season| process_row(season) }
  end

  def process_row(season)
    [season['id'], season['dateStart'][0...10], season['dateEnd'][0...10]]
  end

  def create_table
    DB.create_table? :seasons do
      Integer :id
      Date :start
      Date :end
    end
  end

  def truncate_table
    DB[:seasons].truncate
  end

  def insert_data
    DB[:seasons].import(%i[id start end], @seasons)
  end
end
