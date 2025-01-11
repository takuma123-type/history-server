require 'rails_helper'

RSpec.describe 'CoreStacks API', type: :request do
  describe 'GET /core_stacks' do
    let!(:core_stacks) { create_list(:core_stack, 3) } # FactoryBotを使用

    context '正常系' do
      it 'コアスタック一覧を取得し、200 OK を返す' do
        get '/core_stacks'
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq 'application/json; charset=utf-8'
        expect(JSON.parse(response.body).size).to eq(3)
      end
    end

    # 異常系、準正常系の例: データが存在しない場合など
    # 例えば、データが空の場合など
      context 'データが空の場合' do
        it '空の配列を返し、200 OK を返す' do
          CoreStack.destroy_all
          get '/core_stacks'
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to eq 'application/json; charset=utf-8'
          expect(JSON.parse(response.body)).to eq([])
        end
      end
  end
end