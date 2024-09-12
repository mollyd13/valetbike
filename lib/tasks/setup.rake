require 'csv'

desc "import stations and bike data"
task import: [:environment] do
    CSV.foreach(('./notes/station-data.csv'), headers: true, col_sep: ",") do |row|
        station = Station.new(identifier: row[0], name: row[1], address: row[6])
        station.save!
    end
    CSV.foreach(('./notes/bike-data.csv'), headers: true, col_sep: ",") do |row|
        bike = Bike.new(identifier: row[0], current_station: Station.find_by(identifier: row[1]))
        bike.save!
    end
end