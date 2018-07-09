# class Types::QueryType < Types::BaseObject
#   field :findTicket, function: Resolvers::FindTicket.new
#   field :allTicket, function: Resolvers::AllTicket.new
# end
Types::QueryType = GraphQL::ObjectType.define do
	name 'Query'
	field :findTicket, function: Resolvers::FindTicket.new
  field :allTicket, function: Resolvers::AllTicket.new
end