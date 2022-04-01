class ArticleSerializer
  include JSONAPI::Serializer
  
  attributes :id, :title
  has_many :comments
end
