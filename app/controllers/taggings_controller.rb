class TaggingsController < ApplicationController
  def create
    question = Question.find(params[:question_id])
    if question.tags.where(:name => params[:tag][:name]).empty?
      tag = Tag.find_or_create_by_name(params[:tag][:name])
      begin
        question.tags.push(tag)
      rescue
        flash[:notice] = "Error creating tag"
      end
    end
    redirect_to question_path(question)
  end

  def destroy
    question = @current_user.questions.find_by_id(params[:question_id])
    tagging = question.taggings.find_by_id(params[:id])
    tagging.destroy
    redirect_to question_path(question)
  end
end