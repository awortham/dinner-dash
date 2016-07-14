class Admin::OrdersController < Admin::BaseController
  before_action :set_order, only: :index

  def index
    @all = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)

    redirect_to admin_orders_path, notice: "Order Successfully Updated"
  end

  private

  def set_order
    status = params[:status]

    if Order.valid_statuses.include?(status)
      @orders = Order.where(status: status)
    else
      @orders = Order.all
    end

  end

  def order_params
    params.require(:order).permit(:status)
  end

end
