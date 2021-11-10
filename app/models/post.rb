class Post < ApplicationRecord
  belongs_to :user

  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  # throughオプションによってtag_mapsテーブルを通してtagsテーブルとの関連付けを行う
  # これによりPost.tagsとすればPostに紐付けられたTagの取得が可能になる

  # 投稿を編集する際に以下一連の動作が必要になる
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    # createアクションで保存した@postに紐付くtagが存在する場合、
    # 「タグの名前を配列として」全て取得する
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags
    # 「現在取得した@postに存在するタグ」から「送信されてきたタグ」を除いたタグをold_tags
    # 「送信されてきたタグ」から「現在存在するタグ」を除いたタグをnew_tags

    # 古いタグの削除
    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end

    # 新しいタグの保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_post_tag
    end
  end
end