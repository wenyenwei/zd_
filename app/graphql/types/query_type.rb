class Types::QueryType < Types::BaseObject
  field :findTicket, function: Resolvers::FindTicket.new
end
