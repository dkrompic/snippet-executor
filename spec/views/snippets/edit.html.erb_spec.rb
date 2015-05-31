require 'rails_helper'

RSpec.describe "snippets/edit", type: :view do
    
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryGirl.create(:user)
    sign_in user

    @snippet = assign(:snippet, FactoryGirl.create(:snippet))
  end

  it "renders the edit snippet form" do
    render

    assert_select "form[action=?][method=?]", snippet_path(@snippet), "post" do
      assert_select "input#snippet_name[name=?]", "snippet[name]"
      assert_select "textarea#snippet_content[name=?]", "snippet[content]"
      assert_select "input#snippet_user_id[name=?]", "snippet[user_id]"
    end
  end
end
