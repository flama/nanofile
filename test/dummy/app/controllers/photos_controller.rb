class PhotosController < ApplicationController
  layout 'cms'

  # GET /photos
  def index
    @photos = Photo.all
  end

  # GET /photos/new
  def new
    @photo = Photo.new
  end

  # POST /photos
  def create
    @photo = Photo.new(photo_params)

    if @photo.save
      redirect_to photos_url
    else
      render :new
    end
  end

  # DELETE /photos/1
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to photos_url
  end

  private
    # Only allow a trusted parameter "white list" through.
    def photo_params
      params.require(:photo).permit(:image)
    end
end
