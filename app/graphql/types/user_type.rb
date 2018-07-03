Types::UserType = GraphQL::ObjectType.define do
  name "User"
  field :id, !types.ID
  field :username, !types.String
  field :requestedTickets, types[Types::TicketType] do
    resolve -> (obj, args, ctx) {
    	Ticket.find({ requesterId: obj.id })
    }
  end
  field :assignedTickets, types[Types::TicketType] do
  	resolve -> (obj, args, ctx) {
  		Ticket.find({ assigneeId: obj.id })
  	}
  end
end