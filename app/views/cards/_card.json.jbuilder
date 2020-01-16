json.extract! card, :id, :title, :category_id, :created_at, :updated_at
json.url card_url(card, format: :json)
