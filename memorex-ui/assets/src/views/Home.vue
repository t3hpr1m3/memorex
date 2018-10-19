<template>
  <div class="home">
    <PlaylistForm/>
    <Playlist/>
  </div>
</template>

<script>
import PlaylistForm from "@/components/PlaylistForm.vue";
import Playlist from "@/components/Playlist.vue";

export default {
  name: "home",
  components: {
    PlaylistForm,
    Playlist
  }
};
</script>
