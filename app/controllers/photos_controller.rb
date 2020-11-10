class PhotosController < ApplicationController

  def destroy
    @photo = Photo.find(params[:id])
    book = @photo.book

    @photo.destroy
    @photos = Photo.where(book_id: book.id)

    respond_to :js

  end
end