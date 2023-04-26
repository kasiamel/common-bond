require 'rails_helper'

RSpec.describe ListForm do
  let(:user) { create(:user) }

  let(:params) { load_json_fixture(:list) }

  subject { described_class.new(user.lists.new) }

  context 'with valid parameters' do
    it 'passes the validation' do
      expect(subject.validate(params)).to eq(true)
    end
  end

  context 'without a name' do
    before { params.delete('name') }

    it 'fails the validation' do
      expect(subject.validate(params)).to eq(false)
      expect(subject.errors['name']).to be_present
    end
  end

  context 'without a description' do
    before { params.delete('description') }

    it 'passes the validation' do
      expect(subject.validate(params)).to eq(true)
    end
  end
end
