import React from "react"
import PropTypes from "prop-types"
import ApolloClient from "apollo-boost"
import { ApolloProvider, Query } from "react-apollo"
import gql from "graphql-tag"


const client = new ApolloClient({
  uri: "/graphql"
})

client
  .query({
    query: gql`
      {
        allTicket{
          id
          title
          content
        }
      }
    `
  })
  .then(result => console.log(result))

const ALL_TICKET = gql`
  {
    allTicket{
      id
      title
      content    
    }
  }
`

// const ADD_TICKET = gql`
//       mutation addTicket($title: String!, $content: String!) {
//         addTicket(title: $title, content: $content) {
//           id
//           title
//           content
//         }
//       }
//     `

const TicketData = () => (
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

class Tickets extends React.Component {
  render () {
    return (
      <ApolloProvider client={client}>
        <React.Fragment>
         <div>
           <h4>test title</h4>
           <h5>ticket id: 5b3b709d875037d3b22efd57 title</h5>
           <TicketData/>
         </div>
        </React.Fragment>
      </ApolloProvider>
    );
  }
}

export default Tickets