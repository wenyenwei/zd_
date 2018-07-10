class User
  include Mongoid::Document
  field :uid, type: Integer
  field :username, type: String
end
