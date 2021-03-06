class Api::AnswersController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def index
    question_id = params[:question_id]
    @answers = Question.find(question_id).answers.order created_at: :desc
    # paginate json: @answers, per_page: 10
    render json: @answers
  end

  def create
    question_id = params[:question_id]
    answer = Answer.create(answer_params)
    answer.user_id = current_or_guest_user.id
    answer.question_id = question_id
    render json: answer
  end

  private

  def answer_params
    params.permit(:body, :title, :question_id)
  end

end