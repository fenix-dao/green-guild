# Green Guild

## Dependencies & Frameworks 🧰

### Internet Computer

- **Internet Identity**
- **ICP Ledger Canister**

### Front-End

- **Vue 3** 

- **Tailwind CSS**

### Local Web Server
- **webpack**

## Running the Project Locally 🛠️

To get the project up and running on your local machine, follow these steps:

```
# Starts the replica, running in the background
dfx start --background

# Pull dependecies
dfx deps pull

# Internet Identity initialization
dfx deps init --argument '(null)' internet-identity

# Deploys dependencies to the replica (Internet Identity)
dfx deps deploy

# Install npm dependencies
npm install

# Build FE assets
npm build
```

### Deploy ICP Ledger canister
Check [docs/ICP_LEDGER_CANISTER.md](docs/ICP_LEDGER_CANISTER.md) to deploy icp_ledger_canister

### Deploy ICRC Ledger canister
Check [docs/ICRC1_LEDGER_CANISTER.md](docs/ICRC1_LEDGER_CANISTER.md) to deploy icrc1_ledger_canister

### Deploy FE and Back-end
```
dfx deploy backend_canister
dfx deploy frontend_canister
```

### Start Local Web Server
```
# http://localhost:8080
npm start
```

After deployment, your application will be accessible at `http://localhost:4943?canisterId={asset_canister_id}`.

### Webpack Commands

This project uses Webpack for efficient bundling and compilation of resources. The following commands are integral for building and running the project:

- **npm build**: Compile all the Front-End assets and code

  ```
  npm build
  ```

- **npm start**:

  ```
  npm start # Equivalent to: webpack serve --mode development --env development
  ```

These commands are essential for development, allowing you to quickly build and test changes to the front-end part of the application.
