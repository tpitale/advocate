# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if ENV['RESET']
  Provider.destroy_all
end

if Provider.all.empty?
  providers = [{:name=>"12th & Park Shelter", :address=>"Soulard Area 63104", :city=>"St. Louis", :state=>"MO", :zip=>"63104", :phone=>"314-589-6142"},{:name=>"Gateway 180", :address=>"1000 N. 19th St.", :city=>"St. Louis", :state=>"MO", :zip=>"63106", :phone=>"314-231-1515"},{:name=>"Loaves & Fishes Inc.", :address=>"2750 McKelvey Rd", :city=>"Maryland Heights", :state=>"MO", :zip=>"63043", :phone=>"314-291-3857"},{:name=>"Our Lady's Inn", :address=>"4223 S. Compton Ave", :city=>"St. Louis", :state=>"MO", :zip=>"63111", :phone=>"314-351-4590"},{:name=>"Peter & Paul", :address=>"2612 Wyoming Street", :city=>"St. Louis", :state=>"MO", :zip=>"63118", :phone=>"314-588-7111"},{:name=>"Room at The Inn", :address=>"3415 Bridgeland Drive", :city=>"Bridgeton", :state=>"MO", :zip=>"63044", :phone=>"314-209-9198"},{:name=>"Saint Patrick Center- Women's Night", :address=>"800 N. Tucker Blvd", :city=>"St. Louis", :state=>"MO", :zip=>"63101", :phone=>"314-802-2692"},{:name=>"Salvation Army Family Haven", :address=>"10740 Page Ave", :city=>"St. Louis", :state=>"MO", :zip=>"63132", :phone=>"314-646-3154"},{:name=>"BIDDLE HOUSE OPPORTUNITIES CENTER", :address=>"1212 N 13th St.", :city=>"St. Louis", :state=>"MO", :zip=>"63101", :phone=>"314-802-0700"},{:name=>"SHAMROCK CLUB AT ST. PATRICK'S CENTER", :address=>"800 N. Tucker Blvd", :city=>"St. Louis", :state=>"MO", :zip=>"63101", :phone=>"314-802-0700"},{:name=>"NEW LIFE EVANGELISTIC CENTER", :address=>"1411 Locust", :city=>"St. Louis", :state=>"MO", :zip=>"63103", :phone=>"314-421-3020"},{:name=>"CHRIST CHURCH CATHEDRAL", :address=>"1210 Locust", :city=>"St. Louis", :state=>"MO", :zip=>"63103", :phone=>"314-231-3454"},{:name=>"FATHER DEMPSEY'S HOME", :address=>"3427 Washington", :city=>"St. Louis", :state=>"MO", :zip=>"63103", :phone=>"314-535-7221"},{:name=>"ENERGY CARE", :address=>"2758 Wyoming St.", :city=>"St. Louis", :state=>"MO", :zip=>"63118", :phone=>"314-773-5900"},{:name=>"FRANCISCAN CONNECTION", :address=>"2903 Cherokee St.", :city=>"St. Louis", :state=>"MO", :zip=>"63118", :phone=>"314-773-8485"},{:name=>"PAKT Community Resource Center", :address=>"500 Airport Rd.", :city=>"Ferguson", :state=>"MO", :zip=>"63135", :phone=>"314-524-2710"}]
  providers.each { |provider_attributes| Provider.create!(provider_attributes) }
end

if Service.all.empty?
  services = [{:provider_name=>"12th & Park Shelter", :category=>"Housing", :name=>"Emergency Shelter", :male=>true, :female=>false},{:provider_name=>"Gateway 180", :category=>"Housing", :name=>"Emergency Shelter", :male=>false, :female=>true},{:provider_name=>"Loaves & Fishes Inc.", :category=>"Housing", :name=>"Emergency Shelter", :male=>false, :female=>true},{:provider_name=>"Our Lady's Inn", :category=>"Housing", :name=>"Emergency Shelter", :male=>false, :female=>"TRUE (if pregnant)"},{:provider_name=>"Peter & Paul", :category=>"Housing", :name=>"Emergency Shelter", :male=>true, :female=>false},{:provider_name=>"Room at The Inn", :category=>"Housing", :name=>"Emergency Shelter", :male=>false, :female=>true},{:provider_name=>"Saint Patrick Center- Women's Night", :category=>"Housing", :name=>"Emergency Shelter", :male=>false, :female=>true},{:provider_name=>"Salvation Army Family Haven", :category=>"Housing", :name=>"Emergency Shelter", :male=>true, :female=>true},{:provider_name=>"BIDDLE HOUSE OPPORTUNITIES CENTER", :category=>"Food", :name=>"Food Programs & Pantries", :male=>false, :female=>false},{:provider_name=>"SHAMROCK CLUB AT ST. PATRICK'S CENTER", :category=>"Food", :name=>"Food Programs & Pantries", :male=>false, :female=>false},{:provider_name=>"NEW LIFE EVANGELISTIC CENTER", :category=>"Food", :name=>"Food Programs & Pantries", :male=>false, :female=>false},{:provider_name=>"CHRIST CHURCH CATHEDRAL", :category=>"Food", :name=>"Food Programs & Pantries", :male=>false, :female=>false},{:provider_name=>"FATHER DEMPSEY'S HOME", :category=>"Food", :name=>"Food Programs & Pantries", :male=>false, :female=>false},{:provider_name=>"ENERGY CARE", :category=>"Utilities", :name=>"Utility Assistance", :male=>false, :female=>false},{:provider_name=>"FRANCISCAN CONNECTION", :category=>"Utilities", :name=>"Utility Assistance", :male=>false, :female=>false},{:provider_name=>"PAKT Community Resource Center", :category=>"Utilities", :name=>"Utility Assistance", :male=>false, :female=>false}]
  services.each do |service_attributes|
    provider = Provider.find_by(name: service_attributes[:provider_name])
    service_attributes.delete(:provider_name)
    Service.create!(service_attributes.merge!(provider_id: provider.id))
  end
end

Service.where(name: "Food Programs & Pantries").each{|s|s.update_attribute(:name, "Food Programs")}
