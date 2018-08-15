require "rails_helper"

describe Admin::LinksController, type: :controller do
  let(:long_url) { "http://www.linkedin.com/in/mikeknueppel" }
  let(:link) { Link.create(long_url: long_url, short_url: "http://short_url", admin_url: "http://admin_url") }

  describe "#edit" do
    it "renders the Edit Link form" do
      get :edit, params: { id: link.id }
      expect(response).to render_template("edit")
    end
  end

  describe "#update" do
    before(:each) { Link.destroy_all }

    it "returns a 404 if the ID is invalid" do
      get :show, params: { id: "invalid" }
      expect(response.status).to eql(404)
    end

    it "Admin user can de-activate a short URL" do
      expect(link.is_active).to eql(true)
      put :update, params: { id: link.id, link: { id: link.id, is_active: false } }
      expect(link.reload.is_active).to eql(false)
    end

    it "redirects to the Show URLs page" do
      put :update, params: { id: link.id, link: { id: link.id, is_active: false } }
      expect(response).to render_template("show")
    end
  end
end
