Types::UserType = GraphQL::ObjectType.define do
  name "User"
  field :id, !types.ID
  field :username, !types.String
  field :requestedTickets, types[Types::TicketType] do
    resolve -> (obj, args, ctx) {
    	Ticket.find_by!({ requesterId: obj.id })
    }
  end
  field :assignedTickets, types[Types::TicketType] do
  	resolve -> (obj, args, ctx) {
  		Ticket.find_by!({ assigneeId: obj.id })
  	}
  end
end