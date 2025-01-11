require 'rails_helper'

# Api::Scales のリクエストテスト
# 規模（Scales）データを取得するAPIエンドポイントを検証します。
RSpec.describe "Api::Scales", type: :request do
  describe "GET /api/scales" do
    # テスト用データの作成
    let!(:scale1) { Scale.create!(id: "c7b3737f-6b19-452b-8cf1-0c28ff18c35f", people: "200人以上") }
    let!(:scale2) { Scale.create!(id: "075dd5fa-c89c-4fd7-ab60-357dac9604b0", people: "100人~200人") }

    context "正常系" do
      it "規模データを取得し、ステータス200を返す" do
        # GETリクエストを送信
        get "/api/scales"

        # レスポンスが200 (ok) であることを確認
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)

        # レスポンスデータが期待通りであることを確認
        expect(json).to be_an(Array)
        expect(json.size).to eq(2)
        expect(json[0]).to include("id" => scale1.id, "people" => scale1.people)
        expect(json[1]).to include("id" => scale2.id, "people" => scale2.people)
      end
    end

    context "異常系" do
      before do
        allow(Scale).to receive(:order).and_raise(StandardError, "Something went wrong")
      end

      it "エラーが発生した場合、ステータス500とエラーメッセージを返す" do
        # GETリクエストを送信
        get "/api/scales"

        # レスポンスが500 (internal_server_error) であることを確認
        expect(response).to have_http_status(:internal_server_error)
        json = JSON.parse(response.body)

        # エラーメッセージが含まれていることを確認
        expect(json).to include("error" => "取得できませんでした。")
      end
    end
  end
end
