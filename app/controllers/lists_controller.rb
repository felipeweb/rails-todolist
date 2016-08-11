class ListsController < ApplicationController
  def new
    @list = List.new
  end

  def show
    @list = List.find(id)

    unless @list.created_by?(current_user) or @list.public?
      redirect_to root_path
    end
  end

  def create
    @list = current_user.lists.new(list_params)

    if @list.save
      redirect_to list_path(@list)
    else
      render :new
    end
  end

  def unfavorite
    current_user.remove_favorite_list(List.find(params[:id]))

    render nothing: true
  end

  def favorite
    current_user.add_favorite_list(List.find(params[:id]))

    render nothing: true
  end

  def unmark_public_list
    list = List.find(params[:id])
    List.new.remove_mark_public(list)

    render nothing: true
  end

  def mark_public_list
    list = List.find(params[:id])
    List.new.add_mark_public(list)

    render nothing: true
  end

  def copy_list
    @list = List.new.copy_list(List.find(id), current_user)
    redirect_to @list
  end

  private

  def list_params
    params.require(:list).permit(:name, :public_list)
  end

  def id
    params[:id]
  end
end