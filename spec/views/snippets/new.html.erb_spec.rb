require 'rails_helper'

RSpec.describe "snippets/new", type: :view do
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryGirl.create(:user)
    sign_in user

    assign(:snippet, Snippet.new(
      :name => "MyString",
      :content => "MyText",
      :execution_output => "MyText",
      :user => user
    ))
  end

  it "renders new snippet form" do
    render

    assert_select "form[action=?][method=?]", snippets_path, "post" do
      assert_select "input#snippet_name[name=?]", "snippet[name]"
      assert_select "textarea#snippet_content[name=?]", "snippet[content]"
      assert_select "input#snippet_user_id[name=?]", "snippet[user_id]"
    end
  end
end
