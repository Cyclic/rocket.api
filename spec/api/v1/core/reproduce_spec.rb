describe NL::V2::Core::Reproduce do
  let(:response) {JSON.parse(last_response.body)}

  describe 'GET /' do
    context 'Running reproduce' do
      let(:user_auth_token) {{name: 'ios_client_v_0.1.1', auth_token: 'b33437da561846a66634d598517b488859302f886f55d3c8c31a571b5a319388'}}
      before do
        get '/v2/core/reproduce', {}, authenticated_headers(user_auth_token)
      end
      it do
        expect(last_response).to be_ok
        expect(response['case_is_good']).to be_truthy
      end
    end
  end
end
