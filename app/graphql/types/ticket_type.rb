Types::TicketType = GraphQL::ObjectType.define do
  name "Ticket"
  field :id, !types.ID
  field :title, !types.String
  field :content, types.String
  field :priority, types.String
  field :status, types.String
  field :requester, Types::UserType do
    resolve -> (obj, args, ctx) {
      User.findById(obj.requester)
    }
  end
  field :assignee, Types::UserType do
  	resolve -> (obj, args, ctx) {
  		User.findById(obj.assignee)
  	}
  end
end