# Community Memory Archive

A decentralized platform for storing and sharing community memories on the Stacks blockchain.

## Features

- Store personal and community memories
- Like and comment on memories
- Curator verification system
- Reputation-based system
- Category and tag organization

## Smart Contract Functions

### Public Functions
- `add-memory`: Add a new memory to the archive
- `like-memory`: Like a memory
- `add-comment`: Add comment to a memory
- `verify-memory`: Verify a memory (curators only)
- `appoint-curator`: Appoint a curator (owner only)
- `toggle-contract-pause`: Toggle contract pause (owner only)

### Read-only Functions
- `get-memory`: Get memory details
- `get-user-memories`: Get user memory data
- `get-memory-comment`: Get memory comment
- `get-total-memories`: Get total memories count
- `has-user-liked`: Check if user liked a memory
- `is-user-curator`: Check if user is curator
- `get-contract-status`: Get contract status

## Development

### Prerequisites
- Node.js (v16 or higher)
- Clarinet CLI
- Git

### Setup
1. Clone the repository
2. Install dependencies: `npm  install`
3. Test contracts: `clarinet test`
4. Check contract: `clarinet check`

### Testing
Run tests with: `clarinet test`

## Deployment

Deploy to testnet:
```bash
clarinet deploy --testnet## Status: Ready for Review
