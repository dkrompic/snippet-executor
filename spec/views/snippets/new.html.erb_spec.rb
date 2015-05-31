require 'rails_helper'

RSpec.describe "snippets/new", type: :view do
  before(:each) do
    assign(:snippet, Snippet.new(
      :name => "MyString",
      :content => "MyText",
      :execution_output => "MyText",
      :user => nil
    ))
  end

  it "renders new snippet form" do
    render

    assert_select "form[action=?][method=?]", snippets_path, "post" do

      assert_select "input#snippet_name[name=?]", "snippet[name]"

      assert_select "textarea#snippet_content[name=?]", "snippet[content]"

      assert_select "textarea#snippet_execution_output[name=?]", "snippet[execution_output]"

      assert_select "input#snippet_user_id[name=?]", "snippet[user_id]"
    end
  end
end
