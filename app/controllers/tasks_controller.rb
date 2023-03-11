class TasksController < ApplicationController
  before_action :authorize
  before_action :set_task, only: [:show, :update, :destroy]

  # LIST
  def index
    @tasks = @user.tasks.all
    render json: @tasks
  end

  # SHOW EACH TASK
  def show
    render json: @task
  end

  # POST /tasks
  def create
    @task = Task.new(task_params.merge(user: @user))

    if @task.save
      render json: @task, status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = @user.tasks.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :descrip, :done)
    end
end