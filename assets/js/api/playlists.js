import Axios from 'axios'
import { apiURL } from '../api'

export default {
  fetch
}

async function fetch(playlistId) {
  return Axios.get(`${apiURL}/playlists/${playlistId}`)
    .then(response => {
      return response.data.playlist
    })
    .catch(err => {
      throw(new Error("Invalid Playlist ID"))
    })
}
