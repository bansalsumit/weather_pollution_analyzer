class CreateLocations < ActiveRecord::Migration[7.0]
  def change
    create_table :locations do |t|
      t.text :lat
      t.text :long
      t.text :name
      t.jsonb :api_response
      t.jsonb :api_request

      t.timestamps
    end
  end
end
