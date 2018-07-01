Types::TicketType = GraphQL::ObjectType.define do
  name "Ticket"
  field :id, !types.ID
  field :title, !types.String
  field :content, types.String
  field :priority, types.String
  field :status, types.String
  field :requester, Types::UserType do
    resolve -> (obj, args, ctx) {
    	puts 'requester data', obj+'; '+args+'; '+ctx 
      Requesters.findById(obj.requesterId)
    }
  end
  field :assignee, Types::UserType do
  	resolve -> (obj, args, ctx) {
  		puts 'assignee data', obj+'; '+args+'; '+ctx 
  		Assignees.findById(obj.assigneeId)
  	}
  end
end