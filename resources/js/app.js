
/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

require('./bootstrap');

window.Vue = require('vue');

/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the page. Then, you may begin adding components to this application
 * or customize the JavaScript scaffolding to fit your unique needs.
 */

Vue.component('form-item', require('./components/Form.vue'));
Vue.component('quiz-view', require('./components/QuizView.vue'));
Vue.component('question-list', require('./components/QuestionsList.vue'));
Vue.component('action-bar', require('./components/ActionBar.vue'));
Vue.component('question-buttons', require('./components/QuestionButtons.vue'));
Vue.component('question-item', require('./components/QuestionItem.vue'));
Vue.component('game-list', require('./components/GameList.vue'));
Vue.component('game-item', require('./components/GameItem.vue'));
Vue.component('game-buttons', require('./components/GameButtons.vue'));
Vue.component('game-form', require('./components/GameForm.vue'));
Vue.component('game-group', require('./components/GameGroup.vue'));
Vue.component('game-personal', require('./components/GamePersonal.vue'));
Vue.component('main-view', require('./components/Main.vue'));
Vue.component('search-bar', require('./components/SearchBar.vue'));


Vue.component('view-question', require('./components/ViewQuestion.vue'));
Vue.component('view-answers', require('./components/ViewAnswers.vue'));
Vue.component('view-buttons', require('./components/ViewButtons.vue'));
Vue.component('view-main', require('./components/ViewMain.vue'));

Vue.component('tabs', require('./components/Tabs.vue'));
Vue.component('tab-item', require('./components/TabItem.vue'));

import Toaster from 'v-toaster';
import VTooltip from 'v-tooltip';
import VueRouter from 'vue-router'
import Routes from './routes'
import 'v-toaster/dist/v-toaster.css';
import Main from './components/Main.vue';
import Paginate from 'vuejs-paginate';

Vue.use(Toaster, {timeout: 5000});
Vue.use(VTooltip);
Vue.use(VueRouter);

Vue.component('paginate', Paginate);

const router=new VueRouter({
    routes:Routes,
    mode:'history'
});

export const bus=new Vue();
const app = new Vue({
    el: '#app',
    components: { Main },
    router,
});
