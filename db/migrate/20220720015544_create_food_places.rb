class CreateFoodPlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :food_places do |t|
      t.string :external_id
      t.string :applicant
      t.string :facility_type, index: true
      t.string :address
      t.string :status, index: true
      t.string :fooditems
      t.st_point :geo_point, null: false, geographic: true

      t.timestamps

      t.index :geo_point, using: :gist
    end
  end
end
