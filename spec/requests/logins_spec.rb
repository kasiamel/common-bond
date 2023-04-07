require 'rails_helper'

RSpec.describe 'Logins' do
  let(:path) { '/login' }

  describe 'GET /login' do
    subject! { get path }

    it 'returns the 200 status' do
      expect(response).to have_http_status(200)
    end

    context 'when session already exists' do
      let(:user) { create(:user) }

      it 'redirects to dashboard_path' do
        expect { response.to redirect_to(dashboard_path) }
      end
    end
  end

  describe 'POST /login' do
    let(:user) { create(:user) }

    let(:params) { { email: user.email, password: user.password } }
    let(:session_cookie) { cookies.get_cookie('session_cookie') }

    subject! { post path, params: params }

    it 'redirects to dashboard_path' do
      expect(response).to redirect_to(dashboard_path)
    end

    it 'appends a session cookie' do
      expect(session_cookie).to be_present
      expect(session_cookie.expires).to be_present
      expect(session_cookie).to be_http_only
    end

    context 'with invalid credentials' do
      context 'when invalid password' do
        let(:params) { super().update(password: 'invalid') }

        it 'returns the 200 status' do
          expect(response).to have_http_status(200)
        end

        it 'does not append a session cookie' do
          expect(session_cookie).not_to be_present
        end

        it 'flashes an error message' do
          expect(flash[:alert] = 'Incorrect email or password. Please try again.')
        end
      end

      context 'when email does not exist' do
        let(:params) { super().update(email: 'not-exist-email@email.com') }

        it 'returns the 200 status' do
          expect(response).to have_http_status(200)
        end

        it 'does not append a session cookie' do
          expect(session_cookie).not_to be_present
        end

        it 'flashes an error message' do
          expect(flash[:alert] = 'Incorrect email or password. Please try again.')
        end
      end
    end
  end

  describe 'DELETE /login' do
    let(:session_cookie) { nil }

    subject! { delete path }

    it 'deletes the session cookie' do
      expect(session_cookie).not_to be_present
    end

    it 'redirects to the login page' do
      expect(response).to redirect_to(login_path)
    end

    it 'flashes a notice message' do
      expect(flash[:notice] = 'You have successfully logged out.')
    end
  end
end
