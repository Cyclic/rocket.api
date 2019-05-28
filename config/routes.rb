Rails.application.routes.draw do

  mount API => '/', via: [:head, :get, :put, :post, :delete]
end
