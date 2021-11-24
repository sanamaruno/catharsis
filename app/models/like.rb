class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates_uniqueness_of :post_id, scope: :user_id
  # 同じ投稿を二重でlikesしないようにユーザーと記事の組み合わせを一意にする
end
