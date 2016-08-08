require 'rails_helper'

RSpec.describe List, type: :model do
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:public)}
  it {should validate_presence_of(:user_id)}
end
