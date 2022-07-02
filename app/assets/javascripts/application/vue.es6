//= require vue/dist/vue

Vue.controller = controllerClass => {
  const data = new controllerClass;
  const init = new Function('controller', document.getElementById('controller').dataset.init);

  init(data);

  new Vue({el: '#controller', data: data});
}
