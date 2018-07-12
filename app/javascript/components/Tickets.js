import React from "react"
import PropTypes from "prop-types"
import ApolloClient from "apollo-boost"
import { ApolloProvider, Query } from "react-apollo"
import gql from "graphql-tag"
import { Grid, Row, ListGroup, ListGroupItem, Table } from 'react-bootstrap'


const client = new ApolloClient({
  uri: "/graphql"
})

// client
//   .query({
//     query: gql`
//       {
//         allTicket{
//           id
//           subject
//           description
//           status
//           priority
//         }
//       }
//     `
//   })
//   .then(result => console.log(result))

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

const EDIT_TICKET = gql`
  mutation editTicket($ticket_id: ID!, $subject: String, $description: String, $status: String, $priority: String) {
    editTicket(id: $ticket_id, subject: $subject, description: $description, status: $status, priority: $priority) {
      subject
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

//graphql query findTicket to the requested ticket
const TicketData = ({ticket_id}) => (
  <Query
    query = { FIND_TICKET }
    variables = { { ticket_id } }
  >
    {({ loading, error, data }) => {
      if (loading) return <p>Loading...</p>;
      if (error) return <p>Error :(</p>;
      // load ticket data into ticket form
      const ticket = data.findTicket;
      const ticket_form_item = [];
      for (var item in ticket){
        if (item != "__typename"){
          ticket_form_item.push(
            <div className="ticket-item" key={item}>
              <label>{item.toUpperCase()}</label>
              <textarea
                value={ticket[item]}
                onChange={event => this.setState({[ticket[item]]: event.target.value})}
              />
            </div>
          );
        }
      }        

        return (
          <div className="container"  key={ticket.id}>
            <h3 className="align-center">Edit Ticket {ticket.id}</h3>
            <form>
              {ticket_form_item}
              <button
                className="btn btn-success float-right"
                onClick={async () => {
                  await client.mutation({
                    mutation: EDIT_TICKET,
                    variables: { 
                      subject: this.state.subject,
                      description: this.state.description,
                      status: this.state.status,
                      priority: this.state.priority
                    }
                  });
                }}              
              >
                Save
              </button>
              <a href="/" className="btn btn-warning float-right">Cancel</a>
            </form>
          </div>
        )
    }}
  </Query>
)

class Tickets extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      subject: '',
      description: '',
      status: '',
      priority: ''
    }

  }
  render () {
    console.log(this.props)
    return (
      <ApolloProvider client={client}>
        <React.Fragment>
          <Grid>
            <Row>
             <div>
               <TicketData
                ticket_id = {this.props.ticket_id}
               />
             </div>
            </Row>
          </Grid>
        </React.Fragment>
      </ApolloProvider>
    );
  }
}

export default Tickets