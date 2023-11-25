# Green Guild

## Dependencies & Frameworks 🧰

### Internet Computer

- **Internet Identity**: We use the Internet Computer's Internet Identity service for authentication. This provides a secure, seamless, and decentralized identity verification process, ensuring user privacy and data integrity.

### Front-End

- **Vue 3** 

- **Tailwind CSS**

## Running the Project Locally 🛠️

To get the project up and running on your local machine, follow these steps:

```
# Starts the replica, running in the background
dfx start --background

# Pull dependecies
dfx deps pull

# Internet Identity initialization
dfx deps init --argument '(null)' internet-identity

# Deploys dependencies to the replica
dfx deps deploy

# Install npm dependencies
npm install

# Build FE assets
npm build

# Deploys your canisters to the replica and generates your candid interface
dfx deploy backend_canister
dfx deploy frontend_canister

# Start webpack server
npm start
```

Check docs/ICRC1_LEDGER_CANISTER.md to deploy icrc1_ledger_canister

After deployment, your application will be accessible at `http://localhost:4943?canisterId={asset_canister_id}`.

### Webpack Commands

This project uses Webpack for efficient bundling and compilation of resources. The following commands are integral for building and running the project:

- **npm build**: This command runs Webpack to compile all the assets and code. It ensures that everything is bundled correctly for deployment or testing.

  ```
  npm build
  ```

- **npm start**: This command starts the Webpack development server in development mode. It’s useful for real-time coding and previewing changes without needing to rebuild the entire project.

  ```
  npm start # Equivalent to: webpack serve --mode development --env development
  ```

These commands are essential for development, allowing you to quickly build and test changes to the application.
