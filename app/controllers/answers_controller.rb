class AnswersController < ApplicationController
  # GET /questions/1/answers/1
  # GET /questions/1/answers/1.json
  def show
    @question = Question.find(params[:question_id])

    if !@question
      redirect_to :controller => :questions, :action => "show", :id => params[:question_id]
    end

    @answer = @question.answers.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @answer }
    end
  end

  # GET /questions/1/answers/new
  # GET /questions/1/answers/new.json
  def new
    @question = Question.find(params[:question_id])

    if !@question
      redirect_to :controller => :questions, :action => "show", :id => params[:question_id]
    end

    @answer = Answer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @answer }
    end
  end

  # GET /questions/1/answers/1/edit
  def edit
    @question = Question.find(params[:question_id])

    if !@question
      redirect_to :controller => :questions, :action => "show", :id => params[:question_id]
    end

    @answer = @question.answers.find(params[:id])
  end

  # POST /questions/1/answers
  # POST /questions/1/answers.json
  def create
    @question = Question.find(params[:question_id])

    if !@question
      redirect_to :controller => :questions, :action => "show", :id => params[:question_id]
    end

    @answer = @question.answers.build(params[:answer])
    @answer.user_id = @current_user.id

    respond_to do |format|
      if @answer.save
        format.html { redirect_to @question, notice: 'Answer was successfully created.' }
        format.json { render json: @question, status: :created, location: @question }
      else
        format.html { render action: "new" }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1/answers/1
  # PUT /questions/1/answers/1.json
  def update
    @question = Question.find(params[:question_id])

    if !@question
      redirect_to :controller => :questions, :action => "show", :id => params[:question_id]
    end

    @answer = @question.answers.find(params[:id])

    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        # make other answers wrong
        if params[:answer][:is_right]
          @question.answers.each do |a|
            if a != @answer
              a.is_right = false
              a.save
            end
          end
        end
        format.html { render :template => 'questions/show', :id => @question.id, notice: 'Answer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1/answers/1
  # DELETE /questions/1/answers/1.json
  def destroy
    @question = Question.find(params[:question_id])

    if !@question
      redirect_to :controller => :questions, :action => "show", :id => params[:question_id]
    end

    @answer = @question.answers.find(params[:id])

    @answer.destroy

    respond_to do |format|
      format.html { redirect_to @question }
      format.json { head :no_content }
    end
  end
end
