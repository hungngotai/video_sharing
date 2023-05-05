class Api::V1::VideosController < Api::BaseController
  def index
    videos = Video.all
    render json: { data: videos }, status: :ok
  end

  def create
  end
end
