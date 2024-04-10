require 'httparty'

namespace :poblate_database do
  desc "Llenar la bd con datos de earthquake"
  task load: :environment do
    url = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson'
    response = HTTParty.get(url,{format: :json})

    response['features'].each do |feature|
      prop = feature['properties']
      geometry = feature['geometry']
      Feature.create(external_id: feature['id'], magnitude: prop['mag'], place: prop['place'], time: prop['time'],
                     tsunami: prop['tsunami'], mag_type:prop['magType'], title: prop['title'], url: prop['url'],
                     longitude: geometry['coordinates'][0], latitude: geometry['coordinates'][1]);
    end
  end

end
