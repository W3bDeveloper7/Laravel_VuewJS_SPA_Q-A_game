<template>
    <div class="row">
        <div class="col w3-center w3-margin-top  w3-padding-right">
            <button class="btn btn-success" v-if="user_id==game_user_id" @click="TriggerNextQuestionManually">Next question</button>
        </div>
    </div>
</template>

<script>
    import {bus} from '../app';
    export default {
        name: "view-buttons",
        props: ['game_user_id'],
        data() {
            return {
                user_id:arrVueConfig['user_id']
            }
        },
        methods: {
            TriggerNextQuestionManually(){
                bus.$emit('triggerNextQuestionManually', true);
            }
        }
    }
</script>

<style scoped>
        button{
            margin-right: 10%;
        }
</style>