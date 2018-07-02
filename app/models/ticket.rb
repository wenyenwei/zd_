class Ticket
  include Mongoid::Document
  field :title, type: String
  field :content, type: String
  field :priority, type: String
  field :status, type: String
  field :requester, type: String
  field :assignee, type: String
end
