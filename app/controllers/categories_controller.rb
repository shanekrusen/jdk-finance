class CategoriesController < ApplicationController
    before_filter :authenticate_user

    def new
        @category = Category.new
    end

    def create
        @category = @current_user.categories.create(category_params)
        redirect_to new_income_path
end

    private

    def category_params
        params.require(:category).permit(:name, :color)
    end
end
