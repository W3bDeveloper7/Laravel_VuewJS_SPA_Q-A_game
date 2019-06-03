<template>
    <div class="row">
        <div class="col">
            <div class="w3-display-container w3-green" id="question_container">
                <div class="w3-large w3-padding-top" id="question_content">{{questionName}}</div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "view-question",
        props: ['question'],
        computed: {

            questionName: function () {
                return this.question.question;
            }
        }
    }
</script>

<style scoped>
        #question_container{
            min-height:200px;
            border-radius:10px;
        }
        #question_content{
            text-align: center;
            padding: 35px 30px;
        }
</style>