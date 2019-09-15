class CreateSites < ActiveRecord::Migration[5.2]
  def change
    create_table :sites do |t|
      t.string :url
      t.string :shorten_url

      t.timestamps
    end
  end
end
