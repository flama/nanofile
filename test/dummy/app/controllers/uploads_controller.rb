class UploadsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    render json: ImageUpload.create!(image_params).to_json
  end

  def show
    upload = ImageUpload.find(params[:id])
    src = upload.src
    srcset = upload.srcset

    render json: { src: src, srcset: srcset }
  end

  private

  def image_params
    params.permit(:image)
  end
end
