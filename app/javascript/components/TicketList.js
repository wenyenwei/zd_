import React from "react"
import PropTypes from "prop-types"
import ApolloClient from "apollo-boost"
import { ApolloProvider, Query } from "react-apollo"
import gql from "graphql-tag"

const ALL_TICKET = gql`
  {
    allTicket{
      id
      title
      content    
    }
  }
`

class TicketList extends Component {
	render(){
		return(
		  <Query
		    query={ ALL_TICKET }
		    variables={{ title, content }}
		  >
		    {({ loading, error, data }) => {
		      if (loading) return <p>Loading...</p>;
		      if (error) return <p>Error :(</p>;
		      return data.allTicket.map(ticket => {
		        return (
		          <div key={ticket.id}>
		            <p>{`${ticket.title}: ${ticket.content}`}</p>
		          </div>
		        )
		      })
		    }}
		  </Query>
		)
	}
}

export default graphql(query)(TicketList)