class Resolvers::EditTicket < GraphQL::Function
  # arguments passed as "args"
  argument :id, !types.ID
  argument :subject, types.String
  argument :description, types.String
  argument :priority, types.String
  argument :status, types.String
  argument :requester_id, types.ID
  argument :assignee_id, types.ID


  # return type from the mutation
  type Types::TicketType

  # the mutation method
  # _obj - is parent object, which in this case is nil
  # args - are the arguments passed
  # _ctx - is the GraphQL context (which would be discussed later)
  def call(_obj, args, _ctx)
  	Ticket.where(_id: args[:id]).update(      
      subject: args[:subject],
      description: args[:description],
      priority: args[:priority],
      status: args[:status],
      requester_id: args[:requester_id],
      requester_id: args[:requester_id]
    )
  end
end