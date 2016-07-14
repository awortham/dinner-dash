class Admin::ItemsController < Admin::BaseController

  def index
    @items      = Item.all
    @categories = Category.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    redirect_to admin_items_path, notice: 'Item Successfully Deleted!'
  end

  def create
    @item = Item.create(item_params)

    if @item.valid?
      redirect_to admin_items_path, notice: 'Item Successfully Created!'
    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
    @categories = Category.all
  end

  def update
    @item = Item.find(params[:id])

    if @item.update(item_params)
      @item.categories = Category.where(id: params[:item][:category_ids])
      redirect_to admin_items_path, notice: 'Item Successfully Updated!'
    else
      render :edit
    end
  end

  def new
    @item = Item.new
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :image, :category_ids, :status)
  end

end
