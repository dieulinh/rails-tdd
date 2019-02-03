class CommunesController < ApplicationController

  def index
    respond_to do |format|
      format.json {
        render json: Commune.to_hash
      }

      format.html do
        head :not_acceptable
        nil
      end
    end
  end

  def create
    render json: nil, status: :forbidden
  end

  def show
    commune = Commune.find_by(code_insee: params[:id])
    if commune.blank?
      return render json: nil, status: :not_found
    end

    render json: commune, status: 200
  end

  def update
    commune = Commune.find_by(code_insee: params[:id])
    return render json: nil, status: :not_found if commune.blank?
    return render json: :nothing, status: :bad_request if params[:commune].blank?

    render json: :nothing, status: :no_content if commune.update(commune_params)
  end

  private

  def commune_params
    params.require(:commune).permit(:name)
  end
end
