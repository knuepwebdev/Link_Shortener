require "rails_helper"

describe LinksController, type: :request do
  describe :new do
    it "renders the new link template" do
      get "/links/new"
      expect(response).to render_template(:new)
    end
  end
end
