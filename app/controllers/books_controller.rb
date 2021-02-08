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
    if book.save  #titleとbodyのpresenceがtrueの場合は、saveとredirect
      flash[:notice] = "Book was successfully created."  #サクセスメッセージ
      redirect_to book_path(book.id)  #名前付きルート「as:'book'」→books#show→show.html.erb
    else  #presenceがfalseであれば、エラー表示と共にindexアクション再実行
      @books ||= Book.all  #その際@booksが空の場合はBook.allを改めて代入、それ以外は何もしない
      @book = book #save予定だったブロック変数bookをindex.htmlのif文で使用するためインスタンス変数@bookに代入
      render action: :index
    end
  end

  def show  # 個別レコード表示
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(book.id)  #名前付きルート「as:'book'」→books#show→show.html.erb
    else
      @book = book
      render action: :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "Book was successfully destroyed."
    redirect_to books_path  #名前付きルート「as:'books'」→books#index→index.html.erb
  end

  private
    def book_params
      params.require(:book).permit(:title, :body)
    end

end
