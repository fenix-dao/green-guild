# Internet Computer Bulgaria - Pilot Project 🌐

Welcome to the **Internet Computer Bulgaria** pilot project! This open-source dApp is a collaborative platform where members of the Internet Computer Bulgaria community can actively contribute, share ideas, and participate in decision-making through a **DAO governance model**. 🚀

Our primary goal is to harness the collective intelligence of our community to **ideate, vote**, and bring to life innovative projects on the **Internet Computer Protocol (ICP)**. This project is also a testbed for the **ICP Internet Identity authentication feature**, showcasing the potential and efficiency of decentralized digital identity solutions. 🛠️

We encourage every member, whether a seasoned developer or a curious enthusiast, to contribute their ideas, provide feedback, and help in developing this dApp. Your input is valuable in making this project a success! 🤝

**Key Features**:
1. **Idea Sharing Platform**: Post your ideas and let the community discuss and refine them.
2. **Voting Mechanism**: Use a transparent and fair voting system to select the most popular ideas.
3. **ICP Authentication**: Test and improve the ICP Internet Identity feature within our application.
4. **Open Source Collaboration**: Everything is open-source, allowing for wide community involvement and contribution. 

Let's build something great together! ✨

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

# Deploys your canisters to the replica and generates your candid interface
dfx deploy
```

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
