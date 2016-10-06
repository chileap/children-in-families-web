class AbleScreeningQuestionsController < ApplicationController
  before_action :set_able_screening_question, only: [:edit, :update]

  def new
    @able_screening_question = AbleScreeningQuestion.new
  end

  def create
    @able_screening_question = AbleScreeningQuestion.new(able_screening_question_params)
    if @able_screening_question.save
      redirect_to new_able_screening_question_path, notice: 'Successfully created an Able Screening Question'
    else
      render :new, alert: 'Failed to create an Able Screening Question'
    end
  end

  def edit
  end

  def update
    if @able_screening_question.update_attributes(able_screening_question_params)
      redirect_to edit_able_screening_question_path(@able_screening_question),
                  notice: 'Successfully updated an Able Screening Question'
    else
      render :edit, alert: 'Failed to update an Able Screening Question'
    end
  end

  private
    def able_screening_question_params
      params.require(:able_screening_question)
              .permit(:question, :mode, :question_group_id, :alert_manager,
                      attachments_attributes: [:id, :image])
    end

  protected
    def set_able_screening_question
      @able_screening_question = AbleScreeningQuestion.non_stage
                                                      .find(params[:id])
    end
end