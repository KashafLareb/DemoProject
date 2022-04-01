class CommentSerializer
  include JSONAPI::Serializer
  attribute :comment_body do |comment|
    comment.content.body
  end
  attribute :commenter do |comment|
    User.find(comment.user_id).email
  end
  attribute :created_at do |comment|
    (User.find(comment.user_id).created_at).to_formatted_s(:short)
  end
end
