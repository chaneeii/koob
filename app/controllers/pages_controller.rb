class PagesController < ApplicationController
  def home
    @books = Book.all
  end

  def search

  end
end
