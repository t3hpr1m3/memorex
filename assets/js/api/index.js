import Axios from 'axios'
import playlists from './playlists'

const { socketScheme, scheme, hostname } =
  process.env.NODE_ENV == 'production'
  ? { socketScheme: 'wss',
      scheme: 'https',
      hostname: window.location.hostname }
  : { socketScheme: 'wss',
      scheme: 'http',
      hostname: 'dev1:4003' }

export const apiURL = `${scheme}://${hostname}/api`

export default {
  apiURL : apiURL,
  playlists : playlists
}
