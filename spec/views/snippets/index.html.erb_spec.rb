require 'rails_helper'

RSpec.describe "snippets/index", type: :view do
  user = FactoryGirl.create(:user)

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user

    assign(:snippets, [
      FactoryGirl.create(:snippet, name: "spec snippet 1"),
      FactoryGirl.create(:snippet, name: "spec snippet 2")
    ])
  end

  it "renders a list of snippets" do
    render
    assert_select "tr>td", :text => "spec snippet 1", :count => 1
    assert_select "tr>td", :text => "echo snippet", :count => 2
    # assert_select "tr>td", :text => user.username.to_s, :count => 1
  end
end
