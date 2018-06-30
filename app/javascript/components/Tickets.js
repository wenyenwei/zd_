import React from "react"
import ReactDOM from "react-dom"
import ApolloClient from "apollo-client"
import { ApolloProvider } from "react-apollo"
import PropTypes from "prop-types"
import { InMemoryCache } from 'apollo-cache-inmemory'
import { HttpLink } from 'apollo-link-http'
import TicketList from './TicketList'

class Tickets extends React.Component {
  render () {
  	const cache = new InMemoryCache()
  	const client = new ApolloClient({
  		link: new HttpLink(),
  		cache
  	})

    return (
      <React.Fragment>
      	<ApolloProvider client={client}>
	      	<div>
	      		<TicketList/>
	      	</div>
	    </ApolloProvider>
      </React.Fragment>
    );
  }
}

export default Tickets
