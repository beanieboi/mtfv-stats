class CreateLifetimePlayerStats < ActiveRecord::Migration[6.0]
  def change
    create_view :lifetime_player_stats
  end
end
