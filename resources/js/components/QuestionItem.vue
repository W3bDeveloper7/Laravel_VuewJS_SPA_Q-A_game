<template>
    <div class="row question_item">
        <div class="title_item col">
            <h5>{{question}}</h5>
            <p>{{created_at}}</p>
        </div>
        <div class="col">
            <question-buttons :id="id" :checkbox="checkbox" :status="status" :answers="answers" :game_id="game_id"></question-buttons>
        </div>
        <div class="col-sm-12 divider">
        </div>
    </div>
</template>

<script>
    export default {
        name: "question-item",
        props: ['id','question','created_at','checkbox','status','game_id','answers']
    }
</script>

<style scoped>
    .title_item{
        border-radius: 20px;
        border:1px solid darkgray;
        width: 60%;
        padding: 10px 10px;
    }
    .question_item{
        width: 90%;
        margin: auto;
        padding:15px 15px;
        margin-bottom: 15px;
        border-radius:20px;
    }
    .question_item:hover{
        background-color: #def8c5;
    }
    .divider{
        border-bottom:1px solid #e4e4e4;
        width: 70%;
        margin-top: 10px;
        margin-bottom: 10px;
    }
</style>