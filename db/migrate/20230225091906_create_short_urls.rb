class CreateShortUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :short_urls do |t|
      t.string :long_url
      t.string :code

      t.timestamps
    end
  end
end
