import { defineStore } from "pinia";
import { AuthClient } from "@dfinity/auth-client";
import { createActor, canisterId } from "../../../declarations/backend_canister";
import { toRaw } from "vue";
import { toHexString } from "@dfinity/candid";

const defaultOptions = {
  /**
   *  @type {import("@dfinity/auth-client").AuthClientCreateOptions}
   */
  createOptions: {
    idleOptions: {
      // Set to true if you do not want idle functionality
      disableIdle: true,
    },
  },
  /**
   * @type {import("@dfinity/auth-client").AuthClientLoginOptions}
   */
  loginOptions: {
    identityProvider:
      process.env.DFX_NETWORK === "ic"
        ? "https://identity.ic0.app/#authorize"
        : `http://localhost:4943?canisterId=rdmx6-jaaaa-aaaaa-aaadq-cai#authorize`,
  },
};

function actorFromIdentity(identity) {
  return createActor(canisterId, {
    agentOptions: {
      identity,
    },
  });
}

export const useAuthStore = defineStore("auth", {
  id: "auth",
  state: () => {
    return {
      isReady: false,
      isAuthenticated: null,
      authClient: null,
      identity: null,
      backendActor: null,
      accountId: null,
    };
  },
  actions: {
    async init() {
      const authClient = await AuthClient.create(defaultOptions.createOptions);
      this.authClient = authClient;
      const isAuthenticated = await authClient.isAuthenticated();
      const identity = isAuthenticated ? authClient.getIdentity() : null;
      const backendActor = identity ? actorFromIdentity(identity) : null;

      this.isAuthenticated = isAuthenticated;
      this.identity = identity;
      this.backendActor = backendActor;
      this.isReady = true;

      if(this.isAuthenticated && this.accountId == null) {
        await this.fetchAndUpdateAccountId();
      }
    },
    async login() {
      const authClient = toRaw(this.authClient);
      authClient.login({
        ...defaultOptions.loginOptions,
        onSuccess: async () => {
          this.isAuthenticated = await authClient.isAuthenticated();
          this.identity = this.isAuthenticated
            ? authClient.getIdentity()
            : null;
          this.backendActor = this.identity
            ? actorFromIdentity(this.identity)
            : null;

          await this.fetchAndUpdateAccountId();
        },
      });
    },
    async logout() {
      const authClient = toRaw(this.authClient);
      await authClient?.logout();
      this.isAuthenticated = false;
      this.identity = null;
      this.backendActor = null;
    },
    async fetchAndUpdateAccountId() {
      if (this.isAuthenticated && this.backendActor) {
        try {
          const res = await this.backendActor.getAccountId();
          this.accountId = toHexString(res);
        } catch (error) {
          console.error('Error fetching Account ID:', error);
        }
      }
    },
  },
});