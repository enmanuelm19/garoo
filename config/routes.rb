Rails.application.routes.draw do
  get 'calendars/index'
  get 'functions/index'
  root to: 'functions#index'
end
