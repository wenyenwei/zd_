class ZdApiSchema < GraphQL::Schema
  query(Types::QueryType)
  mutation(Types::MutationType)

  # ticket(Types::Ticket)
  # user(Types::UserType)
end
