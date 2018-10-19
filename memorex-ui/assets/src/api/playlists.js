import Axios from "axios";

export default {
  fetch
};

async function fetch(playlistId) {
  return Axios.get(`/api/v1/playlists/${playlistId}`)
    .then(response => {
      return response.data.playlist;
    })
    .catch(() => {
      throw new Error("Invalid Playlist ID");
    });
}
