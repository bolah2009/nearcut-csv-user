Rails.application.routes.draw do
  root 'csv_service#index', via: %i[get post]
end
