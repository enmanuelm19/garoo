require 'rails_helper'

RSpec.describe Test, type: :model do
  it { should have_many(:notes) }
  it { should belong_to(:course) }  
end
