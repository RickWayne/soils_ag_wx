json.array!(@blogs) do |blog|
  json.extract! blog, :date, :content, :tags
  json.url blog_url(blog, format: :json)
end
