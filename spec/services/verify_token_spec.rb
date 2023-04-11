require 'rails_helper'

RSpec.describe VerifyToken do
  let(:user) { create(:user) }
  let!(:token) { SessionToken.new(user).generate }

  subject { described_class.new(token, :session).call }

  context 'when provided with a valid token' do
    it 'returns a user' do
      expect(subject).to eq(user)
    end
  end

  context 'with an invalid token' do
    let(:token) { JWT.encode({ type: :invalid }, ENV.fetch('HMAC_SECRET'), 'HS256') }

    it 'does not return a user' do
      expect(subject).not_to eq(user)
    end
  end

  context 'without a session token' do
    let(:token) { nil }

    it 'does not return a user' do
      expect(subject).not_to eq(user)
    end
  end

  it "raises an error when user's access has expired" do
    travel(49.hours) do
      expect { subject }.to raise_error(ResponseError)
    end
  end
end
