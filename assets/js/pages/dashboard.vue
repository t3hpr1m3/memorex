<template>
  <div>
    <PlaylistForm/>
    <Playlist/>
  </div>
</template>

<script>
import PlaylistForm from '../components/playlist_form';
import Playlist from '../components/playlist'
export default {
  components: {
    PlaylistForm,
    Playlist
  }
}
</script>
