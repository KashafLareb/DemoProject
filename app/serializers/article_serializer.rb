class ArticleSerializer
  include JSONAPI::Serializer
  
  attributes :title
  attribute :article_content do |article|
    article.content.body
  end
end
