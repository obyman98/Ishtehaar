class GenerateEventsJob < ApplicationJob
  require 'net/http'
  queue_as :default

  def perform(params)
    events = []

    uri = URI('https://maps.googleapis.com/maps/api/geocode/json')
    param = { :administrative_area => 1, :latlng => params['lat'].to_s+","+params['lng'].to_s, :key => "AIzaSyB53v_rdmTRQm8y9Iqa-g9h-2_qO0G6Fuo" }
    uri.query = URI.encode_www_form(param)
    res = Net::HTTP.get_response(uri)
    data = JSON.parse(res.body) if res.is_a?(Net::HTTPSuccess)
    cmp_code = data['plus_code']['compound_code'].split
    location =  cmp_code.include?("Karachi") ? cmp_code[1..-3].join(' ') : cmp_code[1..-2].join(' ')

    #Every 1000 meters = Rs 10
    #Per minutes = Rs 2
    ads = JSON.parse(params['bulk_data'])
    event_durations = Ad.all.where(id: ads.keys()).pluck(:id, :duration).to_h
    ads.each do |set|
      cal_duration = event_durations[set[0].to_i] * set[1]
      events << Event.new(count: set[1], lat: params['lat'], lng: params['lng'], location: location, duration: cal_duration,
                          eld_id: params['eld_id'], ad_id: set[0], event_type: "BACKEND_PROCESSED")
    end
    Event.import events
  end
end
