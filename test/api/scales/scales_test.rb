require 'rails_helper'

RSpec.describe 'Scales API', type: :request do
  describe 'GET /scales' do
    let!(:scales) { create_list(:scale, 3) } # FactoryBotを使用

    context '正常系' do
      it 'スケール一覧を取得し、200 OK を返す' do
        get 'api/scales'
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq 'application/json; charset=utf-8'
        expect(JSON.parse(response.body).size).to eq(3)
      end
    end

    # 異常系、準正常系の例: データが存在しない場合など
    # 例えば、データが空の場合など
      context 'データが空の場合' do
        it '空の配列を返し、200 OK を返す' do
          Scale.destroy_all
          get 'api/scales'
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to eq 'application/json; charset=utf-8'
          expect(JSON.parse(response.body)).to eq([])
        end
      end
  end
end