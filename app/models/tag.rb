class Tag < ApplicationRecord
  has_many :tag_maps, dependent: :destroy, foreign_key: 'tag_id'
  has_many :posts, through: :tag_maps
  # tag_mapsテーブルを通してpostsテーブルと関連付けた
  # これによりTag.postsとすれば、タグに紐付けられたPostを取得できる
end
