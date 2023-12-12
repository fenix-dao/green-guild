<template>
  <div class="text-center">
    <h1 class="h1 font-semibold">
      <span v-if="!isAuthenticated">Proposals Central: Shaping Our Future</span>
      <span v-else>Welcome to "Green Guild" Proposals Page!</span>
    </h1>
    <p>Browse and contribute to the ideas that drive our community forward.</p>
  </div>
  <div class="max-w-[760px] text-lg text-left mx-auto  mt-12 md:space-y-10 space-y-16">
    <img src="covers/proposals-cover.png" class="w-full" />
    <div v-if="isAuthenticated">
      
    </div>
    <div v-else>
      <div class="bg-white shadow-lg rounded-lg p-8 mb-6">
        <div class="mb-6">
            <span class="text-red-600 font-bold text-lg inline-flex items-center">
                🔒 Member Access Required
            </span>
            <p class="text-gray-700 text-md mt-2">It looks like you're not logged in yet. Our proposals page is a space where members of our community come together to shape the future of "Green Guild". Here, you can:</p>
        </div>

        <ul class="list-disc pl-5 mb-6 text-gray-700">
            <li class="mb-2">
                <span class="text-green-600 font-semibold">🌟 View Proposals:</span> 
                Dive into the innovative ideas and plans put forth by our community members.
            </li>
            <li class="mb-2">
                <span class="text-green-600 font-semibold">💡 Submit Your Ideas:</span> 
                Have a vision for our project? Share your proposals and let your voice be heard.
            </li>
            <li class="mb-2">
                <span class="text-green-600 font-semibold">🗳️ Vote on Initiatives:</span> 
                Participate in decision-making by voting on proposals that matter to you.
            </li>
            <li class="mb-2">
                <span class="text-green-600 font-semibold">💬 Discuss and Collaborate:</span> 
                Engage in discussions with fellow members to refine and improve proposals.
            </li>
        </ul>

        <div class="text-gray-700">
            <p class="mb-4">
                🔑 To access these features and join the conversation, please 
                <a href="#" class="text-blue-600 hover:text-blue-800 font-semibold">Log In</a>.
            </p>
            <p>
                Not a member yet? 
                <a href="#" class="text-blue-600 hover:text-blue-800 font-semibold">Join us now</a> 
                and be a part of our growing community!
            </p>
        </div>
    </div>

    </div>
  </div>
</template>

<script setup>
  import { storeToRefs } from "pinia";
  import { backend_canister } from "../../../declarations/backend_canister/index.js";
  import { useAuthStore } from "../store/auth";
import { ref } from "vue";

  const authStore = useAuthStore();
  const { isAuthenticated } = storeToRefs(authStore);

  const proposals = ref(null);

  proposals.value = await backend_canister.getAllProposals();

  console.log(proposals.value);
</script>