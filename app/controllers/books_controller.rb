class BooksController < ApplicationController

  def top
    # トップページ表示
  end

  def index
    # Title、Bodyの一覧を表示
    @books = Book.all

    # newアクション（新規投稿フォーム）は、indexアクション（一覧表示「/books」）同一ページ内
    @book = Book.new  # indexアクション（一覧表示「/books」）実行時に空のモデルを代入
  end

  def create  # 新規投稿フォームの入力内容をデータベースへ追加
    book = Book.new(book_params)
    book.save
    # 仮のリダイレクト先
    redirect_to books_path
  end

  def show  # 個別レコード表示
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    book.update(book_params)
    # 仮のリダイレクト先
    redirect_to books_path
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    # 仮のリダイレクト先
    redirect_to books_path
  end

  private
    def book_params
      params.require(:book).permit(:title, :body)
    end

end
