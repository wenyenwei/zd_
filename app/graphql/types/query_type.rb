class Types::QueryType < Types::BaseObject
  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  # TODO: remove me
  field :ticket, TicketType, null: false,
    description: "query ticket by id"
  def ticket
    Ticket.first
  end
end
