<template>
  <li v-if="title != ''" class="list-group-item">
    <img :src="thumbnails['default']['url']"/>
    <span><strong>{{ title }}</strong></span>
  </li>
</template>

<script>
export default {
  props: ["title", "thumbnails"]
};
</script>
