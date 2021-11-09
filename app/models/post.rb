class Post < ApplicationRecord
  belongs_to :user

  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  # throughオプションによってtag_mapsテーブルを通してtagsテーブルとの関連付けを行う
  # これによりPost.tagsとすればPostに紐付けられたTagの取得が可能になる
end
