class PagesController < ApplicationController
  before_action :set_question, only: %i[show edit update destroy]

  def index
    @pages = Page.all
  end

  def show; end

  def new
    @page = Page.new(parent_id: params[:parent_id])
  end

  def create
    @page = Page.new(page_params)

    if @page.save
      redirect_to page_path(@page)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @page.update(page_params)
      redirect_to page_path(@page)
    else
      render :edit
    end
  end

  def destroy
    @page.destroy
    redirect_to pages_path
  end

  private

  def set_question
    @page = Page.friendly.find(params[:slug])
  end

  def page_params
    params.require(:page).permit(:name, :title, :body, :parent_id)
  end
end
