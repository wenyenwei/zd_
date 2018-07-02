class User
  include Mongoid::Document
  field :id, type: String
  field :username, type: String
end
