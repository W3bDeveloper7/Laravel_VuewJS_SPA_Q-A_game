<template>
    <div>
        <view-main :id="id" :title="title" :personal="personal"></view-main>
    </div>
</template>

<script>
    import {bus} from '../app';
    export default {
        name: "game-group",
        data(){
            return{
                id:this.$route.params.id,
                title:'Group game',
                personal:false
            }
        },
        created(){

        }
    }
</script>

<style scoped>

</style>