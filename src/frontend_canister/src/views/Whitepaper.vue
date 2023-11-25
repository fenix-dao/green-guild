<template>
  <div class="max-w-[760px] text-lg text-left mx-auto md:space-y-10 space-y-16">
    <div v-html="whitepaperContent" class="md"></div>
  </div>
</template>

<script setup>
  import { marked } from "marked";
  import { ref } from "vue";

  const whitepaperContent = ref("");
  whitepaperContent.value = marked.parse("# Whitepaper 📝\n\n\"Green Guide\" is dedicated to fostering a love for nature 🌿 through community-driven governance. Our mission is to build a harmonious and sustainable environment for **nature camping** 🏕️, where everyone can feel connected.\n## Vision and Goals\nOur vision involves creating a vibrant community 👥 centered around a nature camping site equipped with essentials like water 💧, electricity ⚡, tents 🎪, and caravans 🚐. We plan to involve our community in every aspect, from developing the site to hosting enjoyable activities. Our goal is to not only offer a unique camping experience but also to welcome and incorporate visitors' ideas 💡, demonstrating the power of a **community-led approach** in establishing **self-sustaining** camping environments.\n### Membership\nJoining \"Green Guide\" is straightforward and flexible, with two paths to membership:\n\n1. **Contributor Membership**: Simply lock in 1 ICP to instantly become a \"Contributor\" member. This role not only grants you voting rights but also the potential to take on multiple roles, broadening your involvement and impact within the DAO.\n2. **Volunteer Membership**: If you're interested in a more hands-on approach, you can apply to be a \"Volunteer.\" This process involves submitting an application, after which the system will generate a \"Newcomer\" proposal for the community to vote on.\n### Roles\n- **Contributor** - Engage in DAO activities, offering ideas and feedback\n- **Financial Supporter** - Provide funding or investments\n- **Asset Owner** - Hold legal title to physical assets\n- **Volunteer** - Assist in physical tasks on-site, like building, maintenance, and improvements.\n## Decision-Making\nThe heart of our governance is the proposal system. This is how decisions are made:\n- **Proposals**: Members can propose various actions, such as creating new types of proposals, updating roles, transferring funds from the treasury, or making physical decisions about our camping sites.\n- **Voting Power**: Each member's vote carries weight, but not all votes are equal. Your voting power depends on certain factors, likely including your level of involvement and contribution to the DAO.\n- **Types of Proposals**: We recognize the need for different types of proposals, each tailored to specific aspects of DAO operations – from administrative changes to tangible actions on the ground.\n### Proposals Types\n- Decision Making\n- Document Management - Create, Update or Delete\n- Newcomer\n- Funds Transfer - Allocate, Transfer, Withdraw\n- Roles Update\n## Voting\nIn our DAO, voting on important decisions is a privilege reserved for those with at least a \"Contributor\" role, ensuring that decision-making is in the hands of members deeply invested in our long-term objectives. Volunteers, while valued, do not have voting rights. Your voting power is not uniform but is influenced by several factors: the duration of your membership, your participation in events, your voting frequency, and the feedback you receive from fellow members. This approach is intended to reward active, consistent involvement, recognizing those who are truly engaged in the community.\n## Business Model\nTBA\n## Community and Membership\nTBA\n## Technology and Platform\nTBA\n## Tokenomics\nTBA\n");
</script>

<style>
/* Base styles for HTML converted from markdown with .md class */

/* Header styles */
.md h1, .md h2, .md h3, .md h4, .md h5, .md h6 {
    margin-top: 1.2em !important;
    margin-bottom: 0.6em !important;
}

.md h1 {
  margin-top: 0 !important;
}

.md h1 {
    font-size: 2em !important;
}

.md h2 {
    font-size: 1.75em !important;
}

.md h3 {
    font-size: 1.5em !important;
}

.md h4, .md h5, .md h6 {
    font-size: 1.25em !important;
}

/* Paragraph styles */
.md p {
    margin-top: 0.4em !important;
    margin-bottom: 0.8em !important;
}

/* List styles */
.md ul, .md ol {
    margin-top: 0.4em !important;
    margin-bottom: 0.8em !important;
    padding-left: 20px !important;
    list-style-position: inside !important;
}

.md ul {
    list-style-type: disc !important;
}

.md ol {
    list-style-type: decimal !important;
}

/* Bold text */
.md strong, .md b {
    font-weight: bold !important;
}

/* Italic text */
.md em, .md i {
    font-style: italic !important;
}

/* Underlined text */
.md u {
    text-decoration: underline !important;
}

/* Blockquotes */
.md blockquote {
    margin: 0 !important;
    padding-left: 16px !important;
    font-style: italic !important;
}

/* Image styles */
.md img {
    max-width: 100% !important;
    height: auto !important;
}

/* Table styles */
.md table {
    border-collapse: collapse !important;
    width: 100% !important;
}

.md th, .md td {
    border: 1px solid #ddd !important;
    padding: 8px !important;
    text-align: left !important;
}

.md tr:nth-child(even) {
    background-color: #f9f9f9 !important;
}
</style>