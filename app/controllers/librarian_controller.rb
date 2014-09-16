class LibrarianController < ApplicationController
  def index
  end

  def check_out
    @params = params[:book]
    title = @params[:title]
    name = @params[:name]
    @book = Book.find_by_title(title)
    @borrower = Borrower.find_by_name(name)
    if @borrower == nil
      @note = "This borrower is not registered"
    elsif @book == nil
      @note = "This book is not in the library"
    elsif @book.onloan == 1
      @note = "This book is on loan"
    else
      @book.onloan = 1
      @book.save
      @books_loaned = BooksOnLoan.create(book_id: @book.id, borrower_id: @borrower.id)
      @books_loaned.save
      @note = "This book was checked out"
    end
    respond_to do |format|
      format.html
    end
  end

  def check_in
    @params = params[:book]
    title = @params[:title]
    @book = Book.find_by_title(title)
    if @book != nil 
      @book.onloan = 0
      @book.save
      @books_loaned = BooksOnLoan.find_by_book_id(@book.id)
      if @books_loaned != nil
        @books_loaned.destroy
        @note = 'The book was checked in'
      else
        @note = 'Error in books_loaned destroy.'
      end
    else
      @note = 'Book not found'
    end
    respond_to do |format|
      format.html
    end
      
  end

  def list_onloan
    @books_loaned = BooksOnLoan.all
    if @books_loaned == nil
      flash[:notice] = 'No books are on loan'
    else
      respond_to do |format| 
        format.html
      end
    end
  end
end
