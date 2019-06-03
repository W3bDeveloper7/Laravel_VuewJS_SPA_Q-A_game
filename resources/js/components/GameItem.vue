<template>
    <div class="row game_item">
        <div class="title_item col">
            <h5>{{title}}</h5>
            <p>{{created_at}}</p>
        </div>
        <div class="col">
            <game-buttons :id="id" :user_id="user_id"></game-buttons>
        </div>
        <div class="col-sm-12 divider">
        </div>
    </div>
</template>

<script>
    export default {
        name: "game-item",
        props: ['id','title','created_at','user_id']
    }
</script>

<style scoped>
    .title_item{
        border-radius: 20px;
        border:1px solid darkgray;
        width: 60%;
        padding: 10px 10px;
    }
    .game_item{
        width: 90%;
        margin: auto;
        padding:15px 15px;
        margin-bottom: 15px;
        border-radius:20px;
    }
    .game_item:hover{
        background-color: #def8c5;
    }
    .divider{
        border-bottom:1px solid #e4e4e4;
        width: 70%;
        margin-top: 10px;
        margin-bottom: 10px;
    }
</style>