require 'rails_helper'

RSpec.describe "snippets/edit", type: :view do
  before(:each) do
    @snippet = assign(:snippet, Snippet.create!(
      :name => "MyString",
      :content => "MyText",
      :execution_output => "MyText",
      :user => nil
    ))
  end

  it "renders the edit snippet form" do
    render

    assert_select "form[action=?][method=?]", snippet_path(@snippet), "post" do

      assert_select "input#snippet_name[name=?]", "snippet[name]"

      assert_select "textarea#snippet_content[name=?]", "snippet[content]"

      assert_select "textarea#snippet_execution_output[name=?]", "snippet[execution_output]"

      assert_select "input#snippet_user_id[name=?]", "snippet[user_id]"
    end
  end
end
