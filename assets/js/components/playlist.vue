<template>
  <div>
    <div v-if="title != ''" class="text-center">
      <img :src="thumbnails['medium']['url']" />
      <h3>{{ title }}</h3>
    </div>
    <ul class="list-group">
      <PlaylistItem v-for="video in videos" :data="video"/>
    </ul>
  </div>
</template>

<script>
import PlaylistItem from './playlist_item'
export default {
  computed: {
    title() {
      return this.$store.getters['playlists/title']
    },
    thumbnails() {
      return this.$store.getters['playlists/thumbnails']
    },
    videos() {
      return this.$store.getters['playlists/videos']
    }
  },
  components: {
    PlaylistItem
  }
}
</script>
