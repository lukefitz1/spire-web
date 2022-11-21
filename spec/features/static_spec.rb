require 'rails_helper'

describe "navigate" do
  describe "homepage" do
    it "can be reached successfully" do
      visit root_path
      expect(page.status_code).to eq(201)
    end
  end
end
