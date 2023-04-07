require 'rails_helper'

RSpec.describe CreateSession do
  let(:user) { create(:user) }
  let(:email) { user.email }
  let(:password) { user.password }

  subject { described_class.new(email, password).call }

  context 'when provided with valid credentials' do
    it 'returns a session' do
      expect(subject).to be_a(Session)
    end
  end

  context 'when provided with invalid credentials' do
    let(:password) { 'not-exist-email@email.com' }

    it 'does not return a session' do
      expect(subject).not_to be_a(Session)
    end
  end
end
