class Resolvers::AllTicket < GraphQL::Function
  # arguments passed as "args"

  # return type from the mutation
  type types[Types::TicketType]

  # the mutation method
  # _obj - is parent object, which in this case is nil
  # args - are the arguments passed
  # _ctx - is the GraphQL context (which would be discussed later)
  def call(_obj, args, _ctx)
  	Ticket.all
  end
end