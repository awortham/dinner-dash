class Admin::CategoriesController < Admin::BaseController

  def index
    @categories = Category.all
  end

  def destroy
    @category = find_category(:id)
    @category.destroy
    redirect_to admin_categories_path, notice: 'Category Successfully Deleted!'
  end

  def update
    @category = find_category(:id)

    if @category.update(category_params)
      redirect_to admin_categories_path, notice: 'Category Successfully Updated!'
    else
      render :edit
    end
  end

  def edit
    @category = find_category(:id)
  end

  def show
    @category = find_category(:id)
  end

  def create
    @category = Category.create(category_params)

    if @category.valid?
      redirect_to admin_categories_path, notice: 'Category Successfully Created!'
    else
      render :new
    end
  end

  def new
    @category = Category.new
  end

  private

  def find_category(category_id)
    Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end

end
