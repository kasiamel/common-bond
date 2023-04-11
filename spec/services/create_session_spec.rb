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

  context 'when provided with an invalid email' do
    let(:email) { 'no-exist-email@example.com' }

    it 'raises an error' do
      expect { subject.call }.to raise_error(ResponseError)
    end
  end

  context 'when provided with an invalid password' do
    let(:password) { 'invalid' }

    it 'raises an error' do
      expect { subject.call }.to raise_error(ResponseError)
    end
  end
end
