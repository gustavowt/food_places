# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

uri = URI('https://data.sfgov.org/resource/rqzj-sfat.json')
data = JSON.load(uri)

# {"objectid"=>"1337447",
#   "applicant"=>"Liang Bai Ping",
#   "facilitytype"=>"Truck",
#   "cnn"=>"2866000",
#   "locationdescription"=>"BEALE ST: FOLSOM ST to HARRISON ST (300 - 399)",
#   "address"=>"300 BEALE ST",
#   "blocklot"=>"3747022",
#   "block"=>"3747",
#   "lot"=>"022",
#   "permit"=>"19MFF-00079",
#   "status"=>"EXPIRED",
#   "fooditems"=>"Cold Truck: Pre-packaged sandwiches: snacks: fruit: various beverages",
#   "x"=>"6014804.68",
#   "y"=>"2114971.118",
#   "latitude"=>"37.78813947887162",
#   "longitude"=>"-122.39257951537353",
#   "schedule"=>"http://bsm.sfdpw.org/PermitsTracker/reports/report.aspx?title=schedule&report=rptSchedule&params=permit=19MFF-00079&ExportPDF=1&Filename=19MFF-00079_schedule.pdf",
#   "approved"=>"2019-07-12T00:00:00.000",
#   "received"=>"20190712",
#   "priorpermit"=>"1",
#   "expirationdate"=>"2021-01-15T00:00:00.000",
#   "location"=>{"latitude"=>"37.78813947887162", "longitude"=>"-122.39257951537353", "human_address"=>"{\"address\": \"\", \"city\": \"\", \"state\": \"\", \"zip\": \"\"}"},
#   ":@computed_region_yftq_j783"=>"6",
#   ":@computed_region_p5aj_wyqh"=>"2",
#   ":@computed_region_rxqg_mtj9"=>"9",
#   ":@computed_region_bh8s_q3mv"=>"28855",
#   ":@computed_region_fyvs_ahh9"=>"6"}

data.each do |store_info|
  FoodPlace.create(
    external_id: store_info['objectid'],
    applicant: store_info['applicant'],
    facility_type: store_info['facilitytype']&.downcase,
    address: store_info['address'],
    status: store_info['status']&.downcase,
    spherical_point: [
      store_info['longitude'],
      store_info['latitude']
    ],
    fooditems: store_info['fooditems']
  )
end
