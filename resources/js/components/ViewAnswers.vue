<template>
    <div class="row">
        <div class="col-sm-10 col-sm-offset-1">
            <div class="col-sm-5 w3-center answer_item" v-for="(answer, index) in answers"
                 @click="ChooseAnswer(answer.id,index)" :id="answer.id"
                 v-bind:class="{ 'col-sm-offset-1': (answer.id%2)== 0,
                 'selected_correct':isSelected==answer.id && answer.status=='Y',
                 'selected_wrong':isSelected==answer.id && answer.status=='N'
                 }"
            >{{answer.answer}}
            </div>
        </div>
    </div>
</template>

<script>
    import {bus} from '../app'

    export default {
        name: "view-answers",
        props: ['answers','question_id', 'gameFinished','personal'],
        data() {
            return {
                isSelected: "",
                questionTime: 10,
                var_timer: "",
                showTimeOutError:true,
                result: {
                    answer_id: "",
                    time: 0,
                    correct: false
                }
            }
        },
        methods: {
            ChooseAnswer(id, index) {
                if (this.isSelected == "") {
                    this.isSelected = id;

                    //-- Stop question timer
                    this.stopTimer();

                    if (this.answers[index].status == 'Y') {
                        this.result.correct = true;
                        this.$toaster.success('You chose correct answer');
                    } else {
                        this.result.correct = false;
                        this.$toaster.error('The answer is wrong');
                    }
                    this.result.answer_id = id;
                    this.result.time = this.questionTime;
                    this.result.question_id = this.question_id;
                    this.saveResult(this.result);
                    if(this.personal){
                        setTimeout(() => this.nextQuestion(), 3000);
                    }
                }
            },
            saveResult(result) {
                this.$emit('saveResult', result);
            },
            questionTimer() {
                if (this.questionTime > 0) {
                    this.questionTime -= 1;
                    document.getElementById('timerPopup').innerText = this.questionTime;
                } else {
                    this.stopTimer();

                    document.getElementById('timerPopup').style.display = 'none';

                    //-- Check if necessary to show timeout error notification
                    if(this.showTimeOutError){
                        this.$toaster.error('Time is out for this question');
                    }
                    setTimeout(() => this.nextQuestion(), 3000);
                }
            },
            stopTimer() {
                clearInterval(this.var_timer);
            },
            nextQuestion() {

                //-- Activate time out error notification
                this.showTimeOutError=true;

                var arrConfig = {
                    result: this.result,
                    status: true
                };
                this.stopTimer();
                this.$emit('gotAnswer', arrConfig);
            },
            showPopupTimer() {
                var timerPopup = document.getElementById('timerPopup');
                timerPopup.style.display = 'block';
                timerPopup.innerText = this.questionTime;
            }
        },
        created() {
            if (this.personal && !this.gameFinished && this.answers!= undefined) {
                this.var_timer = setInterval(this.questionTimer, 1000);
                this.showPopupTimer();
            }

            bus.$on('nextQuestionAgain', (data) => {
                if (data) {

                    this.isSelected = "";
                    if(this.personal){
                        this.questionTime = 10;
                        this.showPopupTimer();
                        this.var_timer = setInterval(this.questionTimer, 1000);
                    }
                }
            });

            bus.$on('restTimeOutErrorNotification', (data) => {
                this.showTimeOutError=!data;
            });
        }
    }
</script>

<style scoped>
    .answer_item {
        position: relative;
        text-align: center;
        -webkit-transition-duration: 0.4s; /* Safari */
        transition-duration: 0.4s;
        text-decoration: none;
        overflow: hidden;
        cursor: pointer;

        background-color: rgba(120, 224, 144, 0.43);
        padding: 20px 20px;
        margin-top: 10px;
        margin-bottom: 10px;
        border-radius: 10px;
        border: 1px solid rgba(0, 7, 0, 0.67);
    }

    .answer_item:after {
        content: "";
        background: #90EE90;
        display: block;
        position: absolute;
        padding-top: 300%;
        padding-left: 350%;
        margin-left: -20px !important;
        margin-top: -120%;
        opacity: 0;
        transition: all 0.8s
    }

    .answer_item:active:after {
        padding: 0;
        margin: 0;
        opacity: 1;
        transition: 0s
    }

    .selected_correct {
        background-color: rgba(120, 224, 144, 0.8);
    }

    .selected_wrong {
        background-color: rgba(224, 38, 31, 0.55);
    }
</style>