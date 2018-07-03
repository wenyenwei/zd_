class Resolvers::AddTicket < GraphQL::Function
  # arguments passed as "args"
  argument :title, !types.String
  argument :content, types.String
  argument :priority, types.String
  argument :status, types.String
  argument :requesterId, !types.ID
  argument :assigneeId, types.ID


  # return type from the mutation
  type Types::TicketType

  # the mutation method
  # _obj - is parent object, which in this case is nil
  # args - are the arguments passed
  # _ctx - is the GraphQL context (which would be discussed later)
  def call(_obj, args, _ctx)
    Ticket.create!(
      title: args[:title],
      content: args[:content],
      priority: args[:priority],
      status: args[:status],
      requester: args[:requesterId],
      assignee: args[:assigneeId]
    )
  end
end