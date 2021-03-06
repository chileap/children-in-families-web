class QuantitativeCasesController < AdminController
  load_and_authorize_resource

  before_action :find_quantitative_type, only: [:new]
  before_action :find_quantitative_case, only: [:edit, :update, :destroy]

  def index
    @quantitative_types = QuantitativeType.all.paginate(page: params[:page], per_page: 10)
  end

  def new
    @quantitative_case = QuantitativeCase.new(quantitative_type_id: params[:qt_id])
  end

  def create
    @quantitative_case = QuantitativeCase.new(quantitative_case_params)
    if @quantitative_case.save
      redirect_to quantitative_types_path, notice: t('.successfully_created')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @quantitative_case.update_attributes(quantitative_case_params)
      redirect_to quantitative_types_path, notice: t('.successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @quantitative_case.destroy
    redirect_to quantitative_types_path, notice: t('.successfully_deleted')
  end

  private

  def quantitative_case_params
    params.require(:quantitative_case).permit(:quantitative_type_id, :value)
  end

  def find_quantitative_case
    @quantitative_case = QuantitativeCase.find(params[:id])
  end

  def find_quantitative_type
    @quantitative_type = QuantitativeType.find(params[:qt_id])
  end
end
