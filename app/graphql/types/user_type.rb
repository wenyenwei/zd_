Types::UserType = GraphQL::ObjectType.define do
  name "User"
  field :id, !types.ID
  field :username, !types.String
  field :requestedTickets, types[Types::TicketType] do
    resolve -> (obj, args, ctx) {
    	puts 'requestedTickets data', obj+'; '+args+'; '+ctx 
    	Tickets.find({ requesterId: obj.id })
    }
  end
  field :assignedTickets, types[Types::TicketType] do
  	resolve -> (obj, args, ctx) {
  		puts 'assignedTickets data', obj+'; '+args+'; '+ctx 
  		Assignees.find({ assigneeId: obj.id })
  	}
  end
end