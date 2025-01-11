require 'rails_helper'

# Api::Sessions のリクエストテスト
# セッション管理に関するAPIエンドポイント（サインアップ、ログイン）の動作を検証します。
RSpec.describe "Api::Sessions", type: :request do
  describe "POST /api/sessions/sign_up" do
    # 有効なリクエストパラメータ
    let(:valid_params) do
      {
        email: "test@example.com",
        password: "password123",
        name: "Test User"
      }
    end

    # 名前が空のリクエストパラメータ
    let(:missing_name_params) do
      {
        email: "test@example.com",
        password: "password123",
        name: ""
      }
    end

    # 無効なリクエストパラメータ
    let(:invalid_params) do
      {
        email: "",
        password: "",
        name: ""
      }
    end

    context "正常系" do
      it "新しいユーザーを作成し、トークンを返す" do
        # サインアップリクエストを送信
        post "/api/sessions/sign_up", params: valid_params

        # レスポンスが201 (created) であることを確認
        expect(response).to have_http_status(:created)
        json = JSON.parse(response.body)

        # レスポンスにトークンが含まれていることを確認
        expect(json).to include("token")
      end
    end

    context "準正常系" do
      it "名前が空の場合、エラーメッセージを返す" do
        # 名前が空のリクエストを送信
        post "/api/sessions/sign_up", params: missing_name_params

        # レスポンスが422 (unprocessable_entity) であることを確認
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)

        # レスポンスにエラーメッセージが含まれていることを確認
        expect(json).to include("message")
      end
    end

    context "異常系" do
      it "無効なパラメータでエラーメッセージを返す" do
        # 無効なリクエストを送信
        post "/api/sessions/sign_up", params: invalid_params

        # レスポンスが422 (unprocessable_entity) であることを確認
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)

        # レスポンスにエラーメッセージが含まれていることを確認
        expect(json).to include("message")
      end
    end
  end

  describe "POST /api/sessions/log_in" do
    # テスト用のユーザーを作成
    let(:user) do
      authentication = Authentication.create!(
        login_id: "test@example.com",
        password_digest: BCrypt::Password.create("password123")
      )
      User.create!(
        authentication_id: authentication.id,
        name: "Test User"
      )
    end

    # 有効なリクエストパラメータ
    let(:valid_params) do
      {
        email: user.authentication.login_id,
        password: "password123"
      }
    end

    # パスワードが間違っているリクエストパラメータ
    let(:wrong_password_params) do
      {
        email: user.authentication.login_id,
        password: "wrongpassword"
      }
    end

    # 存在しないメールアドレスのリクエストパラメータ
    let(:invalid_params) do
      {
        email: "nonexistent@example.com",
        password: "password123"
      }
    end

    context "正常系" do
      it "ユーザーをログインさせ、トークンを返す" do
        # ログインリクエストを送信
        post "/api/sessions/log_in", params: valid_params

        # レスポンスが200 (ok) であることを確認
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)

        # レスポンスにメッセージとトークンが含まれていることを確認
        expect(json).to include("message", "token")
        expect(json["message"]).to eq("ログイン成功しました。")
      end
    end

    context "準正常系" do
      it "パスワードが間違っている場合、エラーメッセージを返す" do
        # 間違ったパスワードのリクエストを送信
        post "/api/sessions/log_in", params: wrong_password_params

        # レスポンスが422 (unprocessable_entity) であることを確認
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)

        # レスポンスにエラーメッセージが含まれていることを確認
        expect(json).to include("message")
      end
    end

    context "異常系" do
      it "存在しないメールアドレスでエラーメッセージを返す" do
        # 存在しないメールアドレスのリクエストを送信
        post "/api/sessions/log_in", params: invalid_params

        # レスポンスが422 (unprocessable_entity) であることを確認
        expect(response).to have_http_status(:unprocessable_entity)
        json = JSON.parse(response.body)

        # レスポンスにエラーメッセージが含まれていることを確認
        expect(json).to include("message")
      end
    end
  end
end
