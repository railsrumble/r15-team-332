class QuestionsController < ApplicationController

  def index
    raw_questions = Question.order created_at: :desc
    questions_per_page = paginate raw_questions, per_page: 10
    @questions = questions_per_page
  end

  def show
    question_id = params[:id]
    @question = retrieve_question question_id
    @question_id = question_id
    @question_description = @question.description
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.create(question_params)
    redirect_to(@question)
  end

  def retrieve_question id
    Question.find(id)
  end

  private

  def question_params
    params.permit(:description, :recording_id).except(:recording_id).merge(
      user: current_or_guest_user,
      recording: Recording.find(params[:recording_id]
    ))
  end

end
