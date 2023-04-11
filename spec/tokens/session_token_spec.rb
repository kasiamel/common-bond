require 'rails_helper'

RSpec.describe SessionToken do
  let(:user) { create(:user) }
  let(:decoded_token) do
    JWT.decode(subject, ENV.fetch('HMAC_SECRET'), true, { algorithm: 'HS256' })[0]
  end

  subject! { described_class.new(user).generate }

  it 'has a specific type' do
    expect(decoded_token['type']).to eq('session')
  end

  it 'is assigned to a user' do
    expect(decoded_token['user_id']).to eq(user.id)
  end

  it 'expires after 48h' do
    travel(49.hours) do
      expect { decoded_token }.to raise_error(JWT::ExpiredSignature)
    end
  end
end
