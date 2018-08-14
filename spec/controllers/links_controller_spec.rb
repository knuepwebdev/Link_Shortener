require "rails_helper"

describe LinksController, type: :controller do
  let(:long_url) { "http://www.linkedin.com/in/mikeknueppel" }

  describe "new" do
    it "renders the new link template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "create" do
    it "creates a new link" do
      expect(Link.count).to eql(0)
      post :create, params: { link: { long_url: long_url } }
      expect(Link.count).to eql(1)
    end

    it "generates a shortened link" do
      expect(Link.count).to eql(0)
      post :create, params: { link: { long_url: long_url } }
      expect(Link.first.short_url).not_to be_nil
    end

    it "generates an admin link" do
      Link.destroy_all
      expect(Link.count).to eql(0)
      post :create, params: { link: { long_url: long_url } }
      expect(Link.first.admin_url).not_to be_nil
    end    
  end

  describe "show" do
    let(:link) { Link.create(long_url: long_url, short_url: "http://short_url", admin_url: "http://admin_url") }

    it "counts the usage of the short URL" do
      2.times { get :show, params: { id: link.id } }
      expect(link.reload.usage_count).to eql(2)
    end

    it "redirects to the original URL if it's active" do
      get :show, params: { id: link.id }
      expect(response.status).to eql(200)
      expect(response).to render_template("_link")
    end

    it "renders an empty 404 if the short URL is inactive" do
      link.update_attributes(is_active: false)
      get :show, params: { id: link.id }
      expect(response.status).to eql(404)
    end
  end
end
