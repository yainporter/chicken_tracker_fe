require "rails_helper"

RSpec.describe ShelterFacade do

  describe "#shelter" do
    it "can call an api and create a shelter poros" do
      json_response = File.read('spec/fixtures/shelter_1.json')
      stub_request(:get, "http://localhost:5000/api/v1/shelters/1").
      to_return(status: 200, body: json_response, headers: {})

      stub_request(:get, "https://hidden-sands-71693-380133048218.herokuapp.com/api/v1/shelters/1").
      with(
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: json_response, headers: {})

      facade = ShelterFacade.new(id: 1, name: "red barn", user_id: "1")
      shelter = facade.shelter
      
      expect(shelter).to be_a(Shelter)
      expect(shelter.id).to eq(1)
      expect(shelter.name).to eq("red barn")
      expect(shelter.user_id).to eq(1)
    end
  end
end