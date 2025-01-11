require 'rails_helper'

RSpec.describe 'Histories API', type: :request do
  describe 'GET /histories' do
    let!(:histories) { create_list(:history, 3) } # FactoryBotを使用

    context '正常系' do
      it '履歴一覧を取得し、200 OK を返す' do
        get '/histories'
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq 'application/json; charset=utf-8'
        expect(JSON.parse(response.body).size).to eq(3)
      end
    end
     # 異常系、準正常系の例: データが存在しない場合など
    # 例えば、データが空の場合など
    context 'データが空の場合' do
      it '空の配列を返し、200 OK を返す' do
        History.destroy_all
        get '/histories'
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq 'application/json; charset=utf-8'
        expect(JSON.parse(response.body)).to eq([])
      end
    end
  end

  describe 'POST /histories' do
    context '正常系' do
      let(:params) { { history: { title: 'Test History', content: 'This is test content' } } }

      it '履歴が作成され、201 Created を返す' do
        post '/histories', params: params
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq 'application/json; charset=utf-8'
        expect(JSON.parse(response.body)['title']).to eq('Test History')
        expect(History.find_by(title: 'Test History')).to be_present
      end
    end
      context '異常系' do
        it '無効なパラメータの場合、422 Unprocessable Entity を返す' do
          post '/histories', params: { history: { title: '', content: 'This is test content' } }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to eq 'application/json; charset=utf-8'
        end
      end
  end

  describe 'GET /histories/:id' do
    let!(:history) { create(:history, title: 'Test History', content: 'This is test content') } # FactoryBotを使用
      context '正常系' do
        it '指定された履歴を取得し、200 OK を返す' do
            get "/histories/#{history.id}"
            expect(response).to have_http_status(:ok)
            expect(response.content_type).to eq 'application/json; charset=utf-8'
            expect(JSON.parse(response.body)['title']).to eq('Test History')
        end
      end
        context '異常系' do
          it '存在しない履歴を指定した場合、404 Not Found を返す' do
            get "/histories/9999"
            expect(response).to have_http_status(:not_found)
          end
        end
  end

    describe 'GET /histories/:id/export' do
    let!(:history) { create(:history, title: 'Test History', content: 'This is test content') }

    context '正常系' do
      it '指定された履歴をエクスポートし、200 OKを返す' do
          get "/histories/#{history.id}/export"
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to eq 'application/octet-stream'
          expect(response.headers['Content-Disposition']).to include('attachment')
        end
      end

        context '異常系' do
          it '存在しない履歴を指定した場合、404 Not Found を返す' do
            get "/histories/9999/export"
              expect(response).to have_http_status(:not_found)
            end
        end
    end
end