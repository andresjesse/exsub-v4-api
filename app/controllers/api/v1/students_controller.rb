class Api::V1::StudentsController < ApplicationController
  def index
    team = Team.find(params[:team_id])
    render json: team.students.all
  end

  def show
    render json: Team.find(params[:id])
  end

  def create
    student = Student.new(student_params)
    
    if student.save
      render json: student, status: :ok
    else
      render json: nil, status: :unprocessable_entity
    end
  end
  
  def destroy
    student = Student.find(params[:id])
    if student.destroy
      render json: student
    else
      render json: nil, status: :unprocessable_entity 
    end
  end

  def update
    student = Student.find(params[:id])
    if student.update(student_params)
      render json: student
    else
      render json: nil, status: :unprocessable_entity 
    end
  end
  
  private
  def student_params
    params.permit(:name, :ra, :team_id)
  end
end
