class Api::FeaturesController < ApplicationController
  skip_before_action :verify_authenticity_token
  MAX_PER_PAGE = 1000

  def index
    if params[:mag_type].present?
      mag_type = params[:mag_type].split(',')
      features = Feature.where(mag_type: mag_type)
    else
      features = Feature.all
    end
    total = features.count
    current_page = (params[:page] || 1).to_i
    per_page = (params[:per_page] || 10).to_i
    per_page = [per_page, MAX_PER_PAGE].min

    offset = (current_page - 1) * per_page
    @features = features.limit(per_page).offset(offset)

    if @features
      features_data = @features.map do |feature|
        {
          id: feature.id,
          type: 'feature',
          attributes: {
            external_id: feature.external_id,
            magnitude: feature.magnitude,
            place: feature.place,
            time: feature.time,
            tsunami: feature.tsunami,
            mag_type: feature.mag_type,
            title: feature.title,
            coordinates: {
              longitude: feature.longitude,
              latitude: feature.latitude
            }
          },
          links: {
            external_url: feature.url
          }
        }
      end
      pagination_info = {
        current_page: current_page,
        total: total,
        per_page: per_page
      }

      render json: {
        data: features_data,
        pagination: pagination_info
      }, status: :ok
    else
      render json: @features.errors, status: :bad_request
    end
  end

  def show
    @feature = Feature.includes(:comments).find_by(id: params[:id])
    if @feature
      render json: @feature, include: :comments
    else
      render json: { error: "No se encontró" }, status: :not_found
    end
  end

  def create_comment
    feature = Feature.find(params[:feature_id])
    comment = feature.comments.build(comment_params)

    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.permit(:body)
  end

end
