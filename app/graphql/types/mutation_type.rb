# class Types::MutationType < Types::BaseObject
#   # TODO: remove me
#   field :add_ticket,
#     description: "An example field added by the generator"
#   def add_ticket
#     Resolvers::AddTicket.new
#   end
# end
Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'

  field :addTicket, function: Resolvers::AddTicket.new
  field :editTicket, function: Resolvers::EditTicket.new
  field :deleteTicket, function: Resolvers::DeleteTicket.new
end
# class Types::MutationType < Types::BaseObject
#   name 'Mutation'

#   field :add_ticket, String, null: false, 
#   	description: "add ticket"
#   def add_ticket
#   	Resolvers::AddTicket.new
#   end
# end
# class MutationType < GraphQL::Schema::Object

#   # # First describe the field signature:
#   # field :ticket, Types::TicketType, null: true do
#   #   description "Find a ticket by ID"
#   #   argument :id, ID, required: true
#   # end

#   # # Then provide an implementation:
#   # def ticket(id:)
#   #   Ticket.findById(id)
#   # end
#   field :addTicket, TicketType, null: false,
#     description: "add ticket"
#     # argument :id, ID, required: false
#     # argument :title, String, required: true
#     # argument :content, String, required: false
#     # argument :priority, String, required: false
#     # argument :status, String, required: false
#     # argument :requesterId, ID, required: true
#     # argument :assigneeId, ID, required: false
#   def addTicket
#   # (id:,title:, content:, priority:,status:, requesterId:,assigneeId:)
#   #   Ticket.save( { id: id, title: title, content: content, priority: priority, status: status,requesterId: requesterId, assigneeId: assigneeId  } )
#   end
# end

	# name: 'Mutation',
	# fields: {
	# 	addTicket: {
	# 		type: TicketType,
	# 		args: {
	# 			id: { type: GraphQLInt },
	# 			title: { type: new GraphQLNonNull(GraphQLString) },
	# 			content: { type: GraphQLString },
	# 			priority: { type: GraphQLString },
	# 			status: { type: GraphQLString },
	# 			requesterId: { type: new GraphQLNonNull(GraphQLInt) },
	# 			assigneeId: { type: GraphQLInt }
	# 		},
	# 		resolve(parentValue, args){
	# 			return axios.post(`http://localhost:3000/tickets`, args)
	# 				.then(res => res.data);
	# 		}
	# 	},
	# 	deleteTicket: {
	# 		type: TicketType,
	# 		args: {
	# 			id: { type: new GraphQLNonNull(GraphQLInt) }
	# 		},
	# 		resolve(parentValue, { id }){
	# 			return axios.delete(`http://localhost:3000/tickets/${id}`)
	# 				.then(res => res.data);
	# 		}
	# 	},
	# 	editTicket: {
	# 		type: TicketType,
	# 		args: {
	# 			id: { type: new GraphQLNonNull(GraphQLInt) },
	# 			title: { type: GraphQLString },
	# 			content: { type: GraphQLString },
	# 			priority: { type: GraphQLString },
	# 			status: { type: GraphQLString },
	# 			requesterId: { type: GraphQLInt },
	# 			assigneeId: { type: GraphQLInt }
	# 		},
	# 		resolve(parentValue, args){
	# 			return axios.patch(`http://localhost:3000/tickets/${args.id}`, args)
	# 				.then(res => res.data);
	# 		}
	# 	}
	# }