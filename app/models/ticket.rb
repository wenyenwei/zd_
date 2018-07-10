class Ticket
  include Mongoid::Document
  field :subject, type: String
  field :description, type: String
  field :priority, type: String
  field :status, type: String
  field :requester_id, type: String
  field :assignee_id, type: String
end
