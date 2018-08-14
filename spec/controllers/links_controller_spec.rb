require "rails_helper"

describe LinksController, type: :controller do
  describe "new" do
    it "renders the new link template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "create" do
    let(:long_url) { "https://www.linkedin.com/in/mikeknueppel" }

    it "creates a new link" do
      expect(Link.count).to eql(0)
      post :create, params: { link: { long_url: long_url } }
      expect(Link.count).to eql(1)
    end

    it "shortens the link" do
      expect(Link.count).to eql(0)
      post :create, params: { link: { long_url: long_url } }
      expect(Link.first.short_url).not_to be_nil
    end
  end  
end
