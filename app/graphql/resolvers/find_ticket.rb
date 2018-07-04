class Resolvers::FindTicket < GraphQL::Function
  # arguments passed as "args"
  argument :id, !types.ID

  # return type from the mutation
  type Types::TicketType

  # the mutation method
  # _obj - is parent object, which in this case is nil
  # args - are the arguments passed
  # _ctx - is the GraphQL context (which would be discussed later)
  def call(_obj, args, _ctx)
    Ticket.find_by!(id: args[:id])
  end
end