json.extract! request, :id, :email, :reason, :approved, :denied, :created_at, :updated_at
json.url request_url(request, format: :json)
