json.array!(@snippets) do |snippet|
  json.extract! snippet, :id, :name, :content, :execution_output, :user_id
  json.url snippet_url(snippet, format: :json)
end
