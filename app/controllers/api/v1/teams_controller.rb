class Api::V1::TeamsController < ApplicationController
  def index
    render json: Team.all
  end

  def show
    render json: Team.find(params[:id])
  end

  def create
    team = Team.new(team_params)
    
    if team.save
      render json: team, status: :ok
    else
      render json: nil, status: :unprocessable_entity
    end
  end
  
  def destroy
    team = Team.find(params[:id])
    if team.destroy
      render json: team
    else
      render json: nil, status: :unprocessable_entity 
    end
  end

  def update
    team = Team.find(params[:id])
      if team.update(team_params)
        render json: team
      else
        render json: nil, status: :unprocessable_entity 
      end
  end
  
  private
  def team_params
    params.permit(:name, :description)
  end
  
end
