class DrugsController < ApplicationController
  def new
  end
  
  def search
    @drugs = Drug.search(params[:query], fields: [{generic_name: :word_start}], page: params[:page], per_page: 3)
    render :index
  end
  
  def index
    @drugs = Drug.includes(:stores).paginate(page: params[:page], per_page: 15).order('id ASC')
  end
  
  # def show
  #   @drug = Drug.find_by(id: params[:id])
  # end

  def autocomplete
    render json: Drug.search(params[:query], autocomplete: true, limit: 6).map(&:generic_name)
  end
  
  def print
    drugJson = JSON.parse(params[:drugList])
    
    @storeList = drugJson["stores"]
    @drugList = drugJson["drugs"]
  end
end
