require 'rails_helper'

RSpec.describe 'Lists' do
  before { set_session_cookie }

  let(:user) { current_user }

  describe 'GET /list.:id' do
    let(:list) { create(:list) }
    let(:list_user) { create(:list_user, user: current_user, list: list) }

    let(:path) { "/list.#{list.id}" }

    subject! { get path }

    it 'returns 200 status' do
      expect(response).to have_http_status(200)
    end

    it 'returns list details' do
      expect(assigns(:list)).to be_present
      expect(assigns(:list)[:id]).to be_present
      expect(assigns(:list)[:name]).to be_present
      expect(assigns(:list)[:description]).to be_present
    end
  end

  describe 'POST /list' do
    let(:path) { '/list' }
    let(:params) { load_json_fixture(:list) }

    subject! { post path, params: params }

    it 'redirects to list_path details of list' do
      expect(response).to redirect_to(list_path(List.last.id))
    end
  end
end
