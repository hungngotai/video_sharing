class Api::V1::VideosController < Api::BaseController
  def index
    videos = Video.all
    render json: { data: videos }, status: :ok
  end

  def create
    video = Video.new(video_params)
    if video.save
      NotificationChannel.broadcast_to("general", { message: "New video shared by #{current_user.email}"})
      render json: { message: "Create" }, status: :created
    else
      render json: { error: video.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def video_params
    params.require(:video).permit(:src, :description)
  end
end
