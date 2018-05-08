# GraphQL Notes
> ref: https://www.howtographql.com

## Introduction

How GraphQL could be better than REST?

### GraphQL v.s Restful

GraphQL 的優勢:

* Single endpoint (no endless growing endpoints like restful)
* No over-fetching/under-fetching
  1. Fetch everything you need within a single request
  2. over-fetching: download unnecessary data
  3. under-fetching: 1 request does not return enough data and needs more requests!
* Faster feedback cycles & product iterations
* Insightful Analysis
  1. fine-grained info about what data is read by clients
  2. enables evolving API and deprecating unnecessary API features
  3. great opportunities for performance monitoring
* Benefits of Schema & Types
  1. GraphQL uses strong type system to define API
  2. Schema servers as a contract between client side and server side
  3. Front end and Back end teams can work completely independent from each other

### The Schema Definition Language (SDL)

* Add a relation

  ```graphql
  type Person {
    name: String!
    age: Int
    posts: [Post!]!
  }

  type Post {
    title: String!
    author: Person!
  }
  ```

* Fetch data with `Query`

  ```graphql
    {
      allPersons(last: 2) {
        name
        age
        posts {
          title
        }
      }
    }
  ```

* Write Data with `Mutations`
  * **creating** new data
  * **updating** existing data
  * **deleting** existing data

### Root Types

```graphql
  type Query { ... }

  type Mutation { ... }

  type Subscription { ... }
```

* **Query** type:

  ```graphql
    {
      allPersons {
        name
        posts: {
          title
        }
      }
    }

    type Query {
      allPersons(last: Int): [Person!]!
    }
  ```

* **Mutation** type:

  ```graphql
    mutation {
      createPerson(name: "Bob", age: 36) {
        id
      }
    }

    type Mutation {
      createPerson(name: String!, age: Int!): Person!
    }
  ```