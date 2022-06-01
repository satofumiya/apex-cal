import Vue, { createApp } from "vue";
import Vuetify from "vuetify";
import "vuetify/dist/vuetify.min.css";
import App from "../app2.vue";


Vue.use(Vuetify);
const vuetify = new Vuetify();

  document.addEventListener("DOMContentLoaded", () => {
    const app = new Vue({
      vuetify,
      render: h => h(App)
    }).$mount();
    document.body.appendChild(app.$el);
  });