import QuizView from './components/QuizView.vue';
import Main from './components/Main.vue';
import GameGroup from './components/GameGroup.vue';
import GamePersonal from './components/GamePersonal.vue';



export default [
    {path:'/quiz',name: 'quiz',component:QuizView},
    {path:'/group/:id',name: 'game_group',component:GameGroup},
    {path:'/personal/:id',name: 'game_personal',component:GamePersonal},
]
