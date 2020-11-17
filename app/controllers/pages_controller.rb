class PagesController < ApplicationController
  def home
    @books = Book.all
  end

  def user_guide

  end

  def search
    if params[:search].present? && params[:search].strip != ""
      session[:loc_search] = params[:search]
    end

    arrResult = Array.new

    if session[:loc_search] && session[:loc_search] != ""
      @book_address = Book.where(active: true).near(session[:loc_search], 5, order: 'distance')
    else
      @book_address = Book.where(active: true).all
    end

    @search = @book_address.ransack(params[:q])
    @books = @search.result

    @arrBooks = @books.to_a

    if( params[:start_date] && params[:end_date] && !params[:start_date].empty? && !params[:end_date].empty? )

      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])

      @books.each do |book|

        not_available = book.requests.where(
            "(? <= start_date AND start_date <= ?)
            OR (? <= end_date AND end_date <= ?)
            OR (start_date < ? AND ? < end_date)",
            start_date, end_date,
            start_date, end_date,
            start_date, end_date
        ).limit(1)

        if not_available.length > 0
          @arrBooks.delete(book)
        end

      end
    end

    end
end
