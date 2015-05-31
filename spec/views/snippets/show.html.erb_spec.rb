require 'rails_helper'

RSpec.describe "snippets/show", type: :view do
  before(:each) do
    @snippet = assign(:snippet, Snippet.create!(
      :name => "Name",
      :content => "MyText",
      :execution_output => "MyText",
      :user => nil
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
