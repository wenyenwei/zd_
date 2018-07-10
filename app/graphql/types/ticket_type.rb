Types::TicketType = GraphQL::ObjectType.define do
  name "Ticket"
  field :id, !types.ID
  field :subject, !types.String
  field :description, types.String
  field :priority, types.String
  field :status, types.String
  # field :requester_id, Types::UserType do
  #   resolve -> (obj, args, ctx) {
  #     User.find_by(uid: obj.requester_id)
  #   }
  # end
  field :assignee_id, Types::UserType do
  	resolve -> (obj, args, ctx) {
  		User.find_by(uid: obj.assignee_id)
  	}
  end
end