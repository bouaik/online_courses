class EnrollementsController < ApplicationController
  before_action :set_enrollement, only: [:show, :edit, :update, :destroy]
  before_action :set_course, only: [:new, :create]

  def index
    @enrollements = Enrollement.all
    authorize @enrollements
  end

  def show
  end

  def new
    @enrollement = Enrollement.new
  end

  def edit
    authorize @enrollement
  end

  def create
    # @enrollement = Enrollement.new(enrollement_params)
    # @enrollement.price = @enrollement.course.price
    # respond_to do |format|
    #   if @enrollement.save
    #     format.html { redirect_to @enrollement, notice: 'Enrollement was successfully created.' }
    #     format.json { render :show, status: :created, location: @enrollement }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @enrollement.errors, status: :unprocessable_entity }
    #   end
    # end
    if @course.price > 0
      flash[:alert] = "You can't access paid courses yet"
      redirect_to new_course_enrollement_path(@course)
    else
      @enrollements = current_user.buy_course(@course)
      redirect_to course_path(@course), notice: "You are Enrolled!"
    end

  end

  def update
    authorize @enrollement
    respond_to do |format|
      if @enrollement.update(enrollement_params)
        format.html { redirect_to @enrollement, notice: 'Enrollement was successfully updated.' }
        format.json { render :show, status: :ok, location: @enrollement }
      else
        format.html { render :edit }
        format.json { render json: @enrollement.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @enrollement
    @enrollement.destroy
    respond_to do |format|
      format.html { redirect_to enrollements_url, notice: 'Enrollement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions

    def set_course
      @course = Course.friendly.find(params[:course_id])
    end

    def set_enrollement
      @enrollement = Enrollement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def enrollement_params
      params.require(:enrollement).permit(:rating, :review)
    end
end
