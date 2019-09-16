class CreateSiteVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :site_visits do |t|
      t.references :site, foreign_key: true
      t.string :ip_address

      t.timestamps
    end
  end
end
