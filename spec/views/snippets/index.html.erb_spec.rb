require 'rails_helper'

RSpec.describe "snippets/index", type: :view do
  before(:each) do
    assign(:snippets, [
      Snippet.create!(
        :name => "Name",
        :content => "MyText",
        :execution_output => "MyText",
        :user => nil
      ),
      Snippet.create!(
        :name => "Name",
        :content => "MyText",
        :execution_output => "MyText",
        :user => nil
      )
    ])
  end

  it "renders a list of snippets" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
