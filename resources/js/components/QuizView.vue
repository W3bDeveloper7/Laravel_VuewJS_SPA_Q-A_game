<template>
    <div>
        <h1>{{page_title}}</h1>
        <action-bar :actions="actionBar"
                    @changeActionButtonsView="changeActionBar"
                    @goToQuestionList="goToQuestionList"
        ></action-bar>
        <keep-alive :include="included">
            <component :is="activeComponent" v-bind:id="id"></component>
        </keep-alive>
    </div>
</template>

<script>
    import Form from './Form.vue';
    import QuestionsList from './QuestionsList.vue';
    import GameList from './GameList.vue';
    import GameForm from './GameForm.vue';
    import {bus} from '../app';

    export default {
        components: {
            Form,
            QuestionsList,
            GameList,
            GameForm
        },
        name: "quiz-view",
        data() {
            return {
                id: "",
                page_title: 'All games list',
                actionBar: {
                    showQuestionBtn: true,
                    goToList: true,
                    goToGameList: false,
                    newGame: true
                },
                activeComponent: null,
                included: ['questions-list', 'game-list']
            }
        },
        methods: {
            changeActionBar(actionBar) {
                this.actionBar = actionBar;
            },
            goToQuestionList(actionBar) {
                this.page_title = 'My questions list';
                this.activeComponent = QuestionsList;
                this.actionBar = actionBar;
            }
        },
        created() {


            //-- Hide question popup timer
            var timerPopup = document.getElementById('timerPopup');
            if(timerPopup){
                timerPopup.style.display='none';
            }

            this.activeComponent = GameList;
            bus.$on('addQuestion', (data) => {
                if (+data.id > 0) {
                    this.actionBar.showQuestionBtn = data.showQuestionBtn;
                    this.actionBar.goToList = data.goToList;
                    this.id = data.id;
                } else {
                    this.id = "";
                }
                this.page_title = 'Question form';
                this.activeComponent = Form;
            });

            bus.$on('showQuestionsList', (data) => {
                this.actionBar = data;
                this.page_title = 'My questions list';
                this.activeComponent = QuestionsList;
                var arrConfig = {
                    status: true,
                    actionBar: this.actionBar
                };
                bus.$emit('resetQuestionListCache', arrConfig);
            });

            bus.$on('goToGamesList', (data) => {
                this.actionBar.showQuestionBtn = true;
                this.actionBar.goToList = true;
                this.actionBar.goToGameList = false;
                this.actionBar.newGame = true;
                this.page_title = 'All games list';
                this.activeComponent = GameList;
                var arrConfig = {
                    status: true,
                    actionBar: this.actionBar
                };
                bus.$emit('resetGameListCache', arrConfig);
            });

            bus.$on('addNewGame', (data) => {
                this.actionBar.showQuestionBtn = true;
                this.actionBar.goToList = true;
                this.actionBar.goToGameList = true;
                this.actionBar.newGame = false;

                if (+data.id > 0) {
                    this.id = data.id;
                } else {
                    this.id = "";
                }

                //-- Reset session value of selected questions when create new game
                sessionStorage.removeItem("selectedQuestionIDs");

                this.page_title = 'Games form';
                this.activeComponent = GameForm;
            });

            bus.$on('changePageTitle', (data) => {
                this.page_title = data;
            });
        }
    }
</script>

<style scoped>

</style>