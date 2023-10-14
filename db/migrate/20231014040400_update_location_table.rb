class UpdateLocationTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :locations, :api_response, :jsonb
    remove_column :locations, :api_request, :jsonb
    add_column :locations, :state, :text
  end
end
