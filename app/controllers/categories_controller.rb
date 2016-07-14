class CategoriesController < ApplicationController
  layout "special_layout"

  def index
    @category = Category.all
  end
end
