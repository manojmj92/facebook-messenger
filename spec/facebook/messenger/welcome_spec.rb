require 'spec_helper'

describe Facebook::Messenger::Welcome do
  let(:access_token) { '<access token>' }

  let(:thread_settings_url) do
    Facebook::Messenger::Welcome.base_uri + '/thread_settings'
  end

  before do
    Facebook::Messenger.configure do |config|
      config.access_token = access_token
    end
  end

  describe '.set' do
    context 'with a successful response' do
      before do
        stub_request(:post, thread_settings_url)
          .with(
            query: {
              access_token: access_token
            },
            headers: {
              'Content-Type' => 'application/json'
            },
            body: JSON.dump(
              setting_type: 'call_to_actions',
              thread_state: 'new_thread',
              call_to_actions: [
                {
                  message: {
                    text: 'Hello, human!'
                  }
                }
              ]
            )
          )
          .to_return(
            body: JSON.dump(
              result: "Successfully added new thread's CTAs"
            ),
            status: 200,
            headers: default_graph_api_response_headers
          )
      end

      it 'returns true' do
        expect(subject.set(text: 'Hello, human!')).to be(true)
      end
    end

    context 'with an unsuccessful response' do
      let(:error_message) { 'Invalid OAuth access token.' }

      before do
        stub_request(:post, thread_settings_url)
          .with(query: { access_token: access_token })
          .to_return(
            body: JSON.dump(
              'error' => {
                'message' => error_message,
                'type' => 'OAuthException',
                'code' => 190,
                'fbtrace_id' => 'Hlssg2aiVlN'
              }
            ),
            status: 200,
            headers: default_graph_api_response_headers
          )
      end

      it 'raises an error' do
        expect { subject.set text: 'Hello, human!' }.to raise_error(
          Facebook::Messenger::Welcome::Error, error_message
        )
      end
    end
  end

  describe '.unset' do
    context 'with a successful response' do
      before do
        stub_request(:post, thread_settings_url)
          .with(
            query: {
              access_token: access_token
            },
            headers: {
              'Content-Type' => 'application/json'
            },
            body: JSON.dump(
              setting_type: 'call_to_actions',
              thread_state: 'new_thread',
              call_to_actions: []
            )
          )
          .to_return(
            body: JSON.dump(
              result: "Successfully added new thread's CTAs"
            ),
            status: 200,
            headers: default_graph_api_response_headers
          )
      end

      it 'returns true' do
        expect(subject.unset).to be(true)
      end
    end

    context 'with an unsuccessful response' do
      let(:error_message) { 'Invalid OAuth access token.' }

      before do
        stub_request(:post, thread_settings_url)
          .with(query: { access_token: access_token })
          .to_return(
            body: JSON.dump(
              'error' => {
                'message' => error_message,
                'type' => 'OAuthException',
                'code' => 190,
                'fbtrace_id' => 'Hlssg2aiVlN'
              }
            ),
            status: 200,
            headers: default_graph_api_response_headers
          )
      end

      it 'raises an error' do
        expect { subject.unset }.to raise_error(
          Facebook::Messenger::Welcome::Error, error_message
        )
      end
    end
  end
end
