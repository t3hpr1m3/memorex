<template>
  <form class="playlist-form" v-on:submit.prevent="submit">
    <div class="input-group mb-3">
      <input class="form-control" type="text" v-model="playlistId" placeholder="playlist id">
      <div class="input-group-append">
        <button class="btn btn-primary login-button"
                type="submit">
          fetch
        </button>
      </div>
    </div>
  </form>
</template>

<script>
export default {
  name: "playlist-form",
  data: function() {
    return {
      playlistId: ""
    };
  },
  methods: {
    submit() {
      return this.$store.dispatch("Playlists/fetch", this.playlistId);
    }
  }
};
</script>
