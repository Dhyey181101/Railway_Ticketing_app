json.extract! ticket, :id, :user_id, :train_id, :confirmation_number, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
