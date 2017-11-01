class PagesController < ApplicationController
  layout 'cms'

  def show
    render "/pages/#{params[:page]}"
  end
end
