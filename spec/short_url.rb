require 'rails_helper'

RSpec.describe ShortUrlsController, type: :controller do
  describe "POST #encode" do
    context "with valid parameters" do
      let(:long_url) { "https://www.example.com/this-is-a-really-long-url" }
      let(:code) { "abcdef" }

      it "creates a new short URL record" do
        expect {
          post :encode, params: { short_url: { long_url: long_url, code: code } }
        }.to change(ShortUrl, :count).by(1)
      end

      it "returns a redirect response" do
        post :encode, params: { short_url: { long_url: long_url, code: code } }
        expect(response).to have_http_status(:redirect)
      end
    end

    context "with invalid parameters" do
      let(:long_url) { "" }

      it "does not create a new short URL record" do
        expect {
          post :encode, params: { short_url: { long_url: long_url, code: code } }
        }.to_not change(ShortUrl, :count)
      end

      it "returns a redirect response" do
        post :encode, params: { short_url: { long_url: long_url, code: code } }
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "GET #decode" do
    context "with a valid code" do
      let(:short_url) { ShortUrl.create(long_url: "https://www.example.com", code: "abc123") }

      it "redirects to the long URL" do
        get :decode, params: { code: "abc123" }
        expect(response).to redirect_to(short_url.long_url)
      end
    end

    context "with an invalid code" do
      it "returns a 404 error" do
        get :decode, params: { code: "invalid" }
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end

