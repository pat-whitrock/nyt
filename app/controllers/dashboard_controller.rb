class DashboardController < ApplicationController
  def show
    @dashboard = Dashboard.new(params[:language])
  end
end
