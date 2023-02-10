class AddPostCommentToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :post_comment, :text
  end
end
