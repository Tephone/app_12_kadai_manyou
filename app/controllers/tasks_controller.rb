class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :go_login, only: %i[ index ]
  PER = 15

  # GET /tasks or /tasks.json
  def index
  #binding.pry
    
    if params[:sort_expired_at]
      #@tasks = Task.all.order(expired_at: :desc)
      @tasks = current_user.tasks.page(params[:page]).per(PER).order(expired_at: :desc)
    elsif params[:sort_priority]
      #@tasks = Task.all.order(priority: :desc)
      @tasks = current_user.tasks.page(params[:page]).per(PER).order(priority: :desc)

    elsif params[:tag_id]
      if params[:tag_id] != ""
        #@tasks = current_user.tasks.page(params[:page]).per(PER).order(id: :desc)
        @tasks = Tag.find(params[:tag_id]).tasks.page(params[:page]).per(PER) 
      else
        #@tasks = Tag.find(params[:tag_id]).tasks.page(params[:page]).per(PER) 
        @tasks = current_user.tasks.page(params[:page]).per(PER).order(id: :desc)
      end
        
      #@tasks = Tag.find(params[:tag_id]).tasks

    elsif params[:status_search] == "" && params[:title_search] == ""
      #@tasks = Task.all.order(id: :desc)
      @tasks = current_user.tasks.page(params[:page]).per(PER).order(id: :desc)

    elsif params[:status_search] && params[:title_search] == ""
      #@tasks = Task.status_search(params[:status_search]) #default
      #@tasks = Task.where(status: params[:status_search]) #scope
      @tasks = current_user.tasks.page.status_search(params[:status_search]).per(PER) #kaminari
  

    elsif params[:title_search] && params[:status_search] == ""
      #@tasks = Task.where('title LIKE ?', "%#{params[:title_search]}%") #default
      #@tasks = Task.title_search(params[:title_search])  #※scope
      @tasks = current_user.tasks.page.title_search(params[:title_search]).per(PER) #kaminari
      
    elsif params[:title_search] && params[:status_search]
      #@tasks = Task.status_search(params[:status_search]).title_search(params[:title_search]) #scope
      #@tasks = Task.where('title LIKE ?', "%#{params[:title_search]}%").where(status: params[:status_search]) #default
      @tasks = current_user.tasks.page.status_search(params[:status_search]).title_search(params[:title_search]).per(PER)
   
    else
      @tasks = current_user.tasks.page(params[:page]).per(PER).order(id: :desc)
      #@tasks = Task.page(params[:page]).per(PER).order(id: :desc) #全てのユーザーのtask見れる
      #@tasks = Task.all.order(id: :desc)
    end
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    #binding.pry
    @task = current_user.tasks.new(task_params) #１
    #binding.pry
    #@task.tagging_ids.build
    #@task = Task.new(task_params) 
    #@task.user_id = current_user.id #１と同じ意味(association使ってない)
      
    #respond_to do |format|
      if @task.save
        redirect_to task_path(@task.id), notice: "Task was successfully created."
        #format.html { redirect_to @task, notice: "Task was successfully created." }
        #format.json { render :show, status: :created, location: @task }
      else
        render :new
        #format.html { render :new, status: :unprocessable_entity }
        #format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    #end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    #binding.pry
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # def search
  #   @tasks = Task.search(params[:title_search])
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :content, :expired_at, :status, :priority, tag_ids: [])
    end
    def go_login
      unless logged_in?
        redirect_to new_session_path
      end
    end
  end