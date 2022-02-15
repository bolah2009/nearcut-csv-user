require 'rails_helper'

RSpec.describe '/', type: :request do
  shared_examples 'rendering a successful response' do
    it 'renders a successful response' do
      request
      expect(response).to be_successful
    end
  end

  describe 'POST /' do
    subject(:request) { post root_path, params:, headers: }

    let(:params) { '' }

    it_behaves_like 'rendering a successful response'

    context 'with csv upload form request' do
      let(:headers) { { 'Content-Type': 'text/csv' } }
      let(:csv) { fixture_file_upload(filename, 'text/csv') }
      let(:params) { { csv: } }

      context 'with one valid csv data' do
        let(:filename) { 'users.csv' }

        it_behaves_like 'rendering a successful response'

        it 'adds user with successful request' do
          expect { request }.to change(User, :count).by(1)
        end
      end

      context 'with no valid csv data' do
        let(:filename) { 'no_valid_user.csv' }

        it_behaves_like 'rendering a successful response'

        it 'adds user with successful request' do
          expect { request }.to change(User, :count).by(0)
        end
      end
    end
  end
end
