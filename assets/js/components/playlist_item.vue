<template>
  <li v-if="title != ''" class="list-group-item">
    <img :src="data.thumbnails['default']['url']"/>
    <span><strong>{{ data.title }}</strong></span>
  </li>
</template>

<script>
export default {
  props : {
    data: {
      type : Object,
      required : true
    }
  }
}
</script>
