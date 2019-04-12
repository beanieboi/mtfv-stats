class CreateLifetimeDoubleStats < ActiveRecord::Migration[6.0]
  def change
    create_view :lifetime_double_stats
  end
end
