class AddVisitsCountToSite < ActiveRecord::Migration[5.2]
  def change
    add_column :sites, :visits_count, :integer
  end
end
