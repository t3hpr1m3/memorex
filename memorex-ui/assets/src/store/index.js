import Vue from "vue";
import Vuex from "vuex";
import Playlists from "./playlists";

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    Playlists: Playlists
  }
});
