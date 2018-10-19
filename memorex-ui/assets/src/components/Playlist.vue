<template>
  <div>
    <div v-if="title != ''" class="text-center">
      <img :src="thumbnails['medium']['url']" />
      <h3>{{ title }}</h3>
    </div>
    <ul class="list-group">
      <PlaylistItem
        v-for="video in videos"
        v-bind:title="video.title"
        v-bind:thumbnails="video.thumbnails"
        v-bind:key="video.id"
      />
    </ul>
  </div>
</template>

<script>
import PlaylistItem from "./PlaylistItem";
export default {
  computed: {
    title() {
      return this.$store.getters["Playlists/title"];
    },
    thumbnails() {
      return this.$store.getters["Playlists/thumbnails"];
    },
    videos() {
      return this.$store.getters["Playlists/videos"];
    }
  },
  components: {
    PlaylistItem
  }
};
</script>
