class QuestionsController < ApplicationController
  # GET /questions
  # GET /questions.json
  def index
    if params[:unanswered]
      @questions = Question.includes("answers").where(answers: {question_id: nil}).order("questions.created_at DESC")
    else
      @questions = Question.order("created_at DESC")
    end
    @tags = Tag.order("name")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question = Question.find(params[:id])
    @answer = Answer.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question }
    end
  end

  def search
    q = params[:q].upcase
    questions = Question.where("upper(title) LIKE '%"+q.to_s+"%' OR upper(description) LIKE '%"+q.to_s+"%'")
    answers = Answer.where("upper(description) LIKE '%"+q.to_s+"%'")
    @questions = questions + answers.map {|a| a.question}
    @questions.uniq!
  end

  # GET /questions/new
  # GET /questions/new.json
  def new
    if !@current_user
      redirect_to root_path
    end

    @question = Question.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = @current_user.questions.find(params[:id])

    if !@question
      redirect_to :action => "show", :id => params[:id]
    end
  end

  # POST /questions
  # POST /questions.json
  def create
    if !@current_user
      redirect_to root_path
    end

    @question = @current_user.questions.build(params[:question])
    @question.user_id = @current_user.id

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render json: @question, status: :created, location: @question }
      else
        format.html { render action: "new" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.json
  def update
    @question = @current_user.questions.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question = @current_user.questions.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end

end
