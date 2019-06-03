<template>
    <div class="action_bar">
        <button class="btn btn-warning" v-if="actionBar.goToGameList" @click="GoToGameList">Go to games list</button>
        <button class="btn btn-info" v-if="actionBar.showQuestionBtn" @click="AddQuestion">Add question</button>

        <button class="btn btn-success" v-if="actionBar.goToList" @click="GoToQuestionsList">My questions list</button>
        <button class="btn btn-info" v-if="actionBar.newGame" @click="AddGame">Add new game</button>
        <hr>
    </div>
</template>

<script>
    import {bus} from '../app'
    export default {
        name: "action-bar",
        props: ['actions'],
        data() {
            return {
                action:true,
                actionBar:{}
            }
        },
        methods: {
            AddQuestion(){
                bus.$emit('resetSearch', true);
                this.actionBar.showQuestionBtn=false;
                this.actionBar.goToList=true;
                this.actionBar.goToGameList=true;
                this.actionBar.newGame=true;
                this.$emit('changeActionButtonsView',this.actionBar);
                bus.$emit('addQuestion', this.action);
            },
            GoToQuestionsList(){
                bus.$emit('resetSearch', true);
                this.actionBar.showQuestionBtn=true;
                this.actionBar.goToList=false;
                this.actionBar.goToGameList=true;
                this.actionBar.newGame=true;
                this.$emit('goToQuestionList',this.actionBar);
            },
            GoToGameList(){
                bus.$emit('resetSearch', true);
                this.actionBar.showQuestionBtn=true;
                this.actionBar.goToList=true;
                this.actionBar.goToGameList=false;
                this.actionBar.newGame=true;
                bus.$emit('goToGamesList',this.actionBar);
            },
            AddGame(){
                bus.$emit('resetSearch', true);
                this.actionBar.showQuestionBtn=true;
                this.actionBar.goToList=true;
                this.actionBar.goToGameList=true;
                this.actionBar.newGame=false;
                bus.$emit('addNewGame',this.actionBar);
            }
        },
        created(){
            this.actionBar=this.actions;

            //-- Trigger event for ActionBar component
            bus.$on('resetButtons', (data)=>{
                    this.actionBar=data
            });
        }
    }
</script>

<style scoped>
    .action_bar{
        text-align: right;
    }
</style>