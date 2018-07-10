import React from "react"
import PropTypes from "prop-types"
import ApolloClient from "apollo-boost"
import { ApolloProvider, Query } from "react-apollo"
import gql from "graphql-tag"
import { Grid, Row, ListGroup, ListGroupItem, Table } from 'react-bootstrap'


const client = new ApolloClient({
  uri: "/graphql"
})

client
  .query({
    query: gql`
      {
        allTicket{
          id
          subject
          description
          status
          priority
        }
      }
    `
  })
  .then(result => console.log(result))

const ALL_TICKET = gql`
  {
    allTicket{
      id
      subject
      description 
      status
      priority   
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
  >
    {({ loading, error, data }) => {
      if (loading) return <p>Loading...</p>;
      if (error) return <p>Error :(</p>;
      return data.allTicket.map(ticket => {
        return (
          <ListGroupItem key={ticket.id}>
            <Table>
              <tr>
                <th>{ticket.subject}</th>
                <th>{ticket.id}</th>
                <th>{ticket.status}</th>
                <th>{ticket.priority}</th>
              </tr>
            </Table>
          </ListGroupItem>
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
          <Grid>
            <Row>
             <div>
               <h4>test title</h4>
               <ListGroup>
                 <TicketData/>
               </ListGroup>
             </div>
            </Row>
          </Grid>
        </React.Fragment>
      </ApolloProvider>
    );
  }
}

export default Tickets