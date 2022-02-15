class CsvServiceController < ApplicationController
  before_action :check_csv, only: :index

  def index; end

  private

  def check_csv
    return if params[:csv].blank?

    file_path = params[:csv].tempfile
    @results = Nearcut::UserRegistrationService.new(file_path).results
  end
end
