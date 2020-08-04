require 'rails_helper'

RSpec.describe "Munchie Request" do
  it "Destination Forecast and Food Request" do
    get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese'

    expect(response).to be_successful

    parsed_munchies_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_munchies_response).to have_key(:data)
    expect(parsed_munchies_response[:data]).to have_key(:id)
    expect(parsed_munchies_response[:data]).to have_key(:type)
    expect(parsed_munchies_response[:data]).to have_key(:attributes)
    expect(parsed_munchies_response[:data][:attributes]).to have_key(:start_location)
    expect(parsed_munchies_response[:data][:attributes]).to have_key(:end_location)
    expect(parsed_munchies_response[:data][:attributes]).to have_key(:destination_forecast)
    expect(parsed_munchies_response[:data][:attributes][:destination_forecast]).to have_key(:current)
    expect(parsed_munchies_response[:data][:attributes]).to have_key(:restaurant)
    expect(parsed_munchies_response[:data][:attributes][:restaurant]).to have_key(:name)
    expect(parsed_munchies_response[:data][:attributes][:restaurant]).to have_key(:address)

    expect(parsed_munchies_response[:data]).to_not eq(nil)
    expect(parsed_munchies_response[:data][:id]).to eq("null")
    expect(parsed_munchies_response[:data][:type]).to eq("munchies")
    expect(parsed_munchies_response[:data][:attributes]).to_not eq(nil)
    expect(parsed_munchies_response[:data][:attributes][:start_location]).to_not eq(nil)
    expect(parsed_munchies_response[:data][:attributes][:end_location]).to_not eq(nil)
    expect(parsed_munchies_response[:data][:attributes][:destination_forecast]).to_not eq(nil)
    expect(parsed_munchies_response[:data][:attributes][:destination_forecast][:current]).to_not eq(nil)
    expect(parsed_munchies_response[:data][:attributes][:restaurant]).to_not eq(nil)
    expect(parsed_munchies_response[:data][:attributes][:restaurant][:name]).to_not eq(nil)
    expect(parsed_munchies_response[:data][:attributes][:restaurant][:address]).to_not eq(nil)
    end
  end
