require 'rails_helper'

RSpec.describe "snippets/show", type: :view do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryGirl.create(:user)
    sign_in user

    @snippet = assign(:snippet, Snippet.create!(
      :name => "Name",
      :content => "MyText",
      :execution_output => "MyText",
      :user => user
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
