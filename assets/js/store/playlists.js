import api from '../api'

export default {
  namespaced: true,
  state: {
    title: '',
    thumbnails: {},
    videos: []
  },
  getters: {
    title : state => {
      return state.title
    },
    thumbnails : state => {
      return state.thumbnails
    },
    videos : state => {
      return state.videos.sort((a, b) => a.position - b.position)
    }
  },
  mutations: {
    title(state, title) {
      state.title = title
    },
    thumbnails(state, thumbnails) {
      state.thumbnails = thumbnails
    },
    videos(state, videos) {
      state.videos = videos
    },
    reset(state) {
      state.title = ''
      state.thumbnail = ''
      state.videos = []
    }
  },
  actions: {
    fetch({ commit }, id) {
      commit('reset')
      api.playlists.fetch(id)
        .then(data => {
          commit('title', data.playlist.title)
          commit('thumbnails', data.playlist.thumbnails)
          commit('videos', data.playlist.items)
        })
        .catch(err => {
          commit('reset')
        })
    }
  }
}
