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

const FIND_TICKET = gql`
  query findTicket($ticket_id: ID!) {
    findTicket(id: $ticket_id) {
      id
      subject
      description 
      status
      priority
    }
  }
`;

// const ADD_TICKET = gql`
//       mutation addTicket($title: String!, $content: String!) {
//         addTicket(title: $title, content: $content) {
//           id
//           title
//           content
//         }
//       }
//     `

const TicketData = ({ticket_id}) => (
  <Query
    query = { FIND_TICKET }
    variables = { { ticket_id } }
  >
    {({ loading, error, data }) => {
      if (loading) return <p>Loading...</p>;
      if (error) return <p>Error :(</p>;
        console.log('data', data)
      const ticket = data.findTicket;
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
    }}
  </Query>
)

class Tickets extends React.Component {
  render () {
    console.log(this.props)
    return (
      <ApolloProvider client={client}>
        <React.Fragment>
          <Grid>
            <Row>
             <div>
               <h4>test title</h4>
               <ListGroup>
                 <TicketData
                  ticket_id = {this.props.ticket_id}
                 />
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