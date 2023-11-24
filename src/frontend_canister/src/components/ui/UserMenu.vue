<template>
  <div>
    <Menu as="div" class="relative inline-block text-left top-1">
      <div>
        <MenuButton class="">
          <UserCircleIcon
            class="h-8 w-8 hover:text-blue-600"
            aria-hidden="true"
          />
        </MenuButton>
      </div>

      <transition
        enter-active-class="transition duration-100 ease-out"
        enter-from-class="transform scale-95 opacity-0"
        enter-to-class="transform scale-100 opacity-100"
        leave-active-class="transition duration-75 ease-in"
        leave-from-class="transform scale-100 opacity-100"
        leave-to-class="transform scale-95 opacity-0"
      >
        <MenuItems
          class="absolute right-0 mt-2 w-56 origin-top-right divide-y divide-gray-100 rounded-md bg-white shadow-lg ring-1 ring-black/5 focus:outline-none"
        >
          <div class="px-1 py-1">
            <MenuItem v-slot="{ active }">
              <router-link 
                :to="{name: 'Wallet'}"
                :class="[
                  active ? 'bg-blue-600 text-white' : 'text-gray-900',
                  'group flex w-full items-center rounded-md px-2 py-2 text-sm',
                ]"
              >
                <CreditCardIcon
                  class="h-5 w-5 mr-2"
                  aria-hidden="true"
                />
                Портфейл
              </router-link>
            </MenuItem>
          </div>
          <div class="px-1 py-1">
            <MenuItem v-slot="{ active }">
              <button
                type="button"
                id="logoutButton"
                :class="[
                  active ? 'bg-blue-600 text-white' : 'text-gray-900',
                  'group flex w-full items-center rounded-md px-2 py-2 text-sm',
                ]"

                @click="logout()"
              >
                <PowerIcon
                  class="h-5 w-5 mr-2 drop-shadow-lg"
                  aria-hidden="true"
                />
                Изход
              </button>
            </MenuItem>
          </div>
        </MenuItems>
      </transition>
    </Menu>
  </div>
</template>

<script setup>
  import { Menu, MenuButton, MenuItems, MenuItem } from '@headlessui/vue'
  import { UserCircleIcon, PowerIcon, CreditCardIcon } from '@heroicons/vue/20/solid'
  import { useAuthStore } from '../../store/auth';
  import { useRouter } from 'vue-router'; // Import useRouter

  const authStore = useAuthStore();
  const router = useRouter();

  async function logout() {
    await authStore.logout();
    router.push('/'); // Navigate to home
  }
</script>