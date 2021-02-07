class Book < ApplicationRecord
  # validates :カラム名, _____
  # presence：指定された属性が「空でない」ことを確認＝false→空欄
  validates :title, presence: true
  validates :body, presence: true

  # 上記の記述はDBに登録されないだけ
  # save/updateがfalseの場合にエラーメッセージを返すようにする

end