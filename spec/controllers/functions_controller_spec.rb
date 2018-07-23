require 'rails_helper'

RSpec.describe FunctionsController, type: :controller do
  it 'shows number of 0 given factorial number' do
    get :index, params: { factorial: 5 }
    expect(assigns(:result_factorial)).to eq(1)
  end

  it 'show number in words' do
    get :index, params: { number: 145 }
    expect(assigns(:number_to_translate)).to eq('ciento cuarenta y cinco')
  end
end
