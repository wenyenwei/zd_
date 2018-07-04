class Resolvers::EditTicket < GraphQL::Function
  # arguments passed as "args"
  argument :id, !types.ID
  argument :title, types.String
  argument :content, types.String
  argument :priority, types.String
  argument :status, types.String
  argument :requester, types.ID
  argument :assignee, types.ID


  # return type from the mutation
  type Types::TicketType

  # the mutation method
  # _obj - is parent object, which in this case is nil
  # args - are the arguments passed
  # _ctx - is the GraphQL context (which would be discussed later)
  def call(_obj, args, _ctx)
  	Ticket.where(_id: args[:id]).update_attributes(args)
  end
end