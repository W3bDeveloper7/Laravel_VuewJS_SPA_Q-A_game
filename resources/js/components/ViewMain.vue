<template>
    <div>
        <slot name="header">
            <div><h1 style="display: inline;">{{game.title}}</h1>
                <span class="w3-tag"
                                                                        v-bind:class="{ 'w3-orange': personal,
                 'w3-teal': !personal
                 }"
            >{{personal?'Personal game':'Group game'}}</span>
                <span v-if="!personal && user_id===+game.user_id" class="w3-text-red"><b>{{numberOfUsers}}</b> other player(s) in this game</span>
            </div>
        </slot>
        <div v-if="!gameFinished">
            <view-question :question="currentQuestion"></view-question>
            <view-answers @gotAnswer="nextQuestion" @saveResult="saveResult" :question_id="currentQuestion.id"
                          :gameFinished="gameFinished"
                          :answers="currentQuestion.answers" :personal="personal"></view-answers>
            <view-buttons v-if="!personal" :game_user_id="game.user_id"></view-buttons>
        </div>
        <div v-else class="w3-text-green">
            {{afterGameMessage}}
            <p><a href="#" @click="PlayAgain">Play game again</a></p>
            <div id="results">
                <h3>Results</h3>  <h1 class="w3-text-red">{{resultStatistic}}</h1>
                <div v-for="result,key in finalResult.questions" class="w3-text-black">
                    <p>
                        Question № {{key+1}}: <b>{{questionNames[result]}}</b>
                    </p>
                    <p>Result: <b :class="{ 'w3-text-green': finalResult.status[key]==true,
                     'w3-text-red': finalResult.status[key]==false,
                     }">{{finalResult.status[key]}}</b></p>
                    <p v-if="personal">Time: <b>{{finalResult.time[key]}} second(s)</b></p>
                    <hr>
                </div>

                <div v-if="!personal">
                    <div v-if="allUsers && Object.keys(otherGameResults).length>1" class="w3-text-black">
                        <h4 class="w3-text-green"><b>Results of other players that played with you</b></h4>
                        <table class="w3-table w3-striped">
                            <tr>
                                <th>User name</th>
                                <th>Result</th>
                            </tr>
                            <tr v-for="result,key in otherGameResults" v-show="key!=user_id">
                                <td>{{allUsers[key]['name']}}</td>
                                <td class="w3-text-red"><b>{{result}} from {{otherGameUserQuestionsPlayed[key]}}</b></td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>
</template>

<script>
    import {bus} from '../app';
    import Swal from 'sweetalert2';

    export default {
        name: "view-main",
        props: ['id', 'title', 'personal'],
        data() {
            return {
                game: {
                    title: "",
                    id: null,
                    user_id: null
                },
                user_id:arrVueConfig['user_id'],
                gameFinished: false,
                questions: [],
                allUsers: [],
                questionsPusher: [],
                otherGameResults:{},
                otherGameUserQuestionsPlayed:{},
                questionNames: [],
                currentQuestionID: 0,
                currentQuestion: {},
                answers: {},
                result: {
                    questions: [],
                    answers: [],
                    status: [],
                    time: []
                },
                finalResult: [],
                gameOwner: {
                    id: "",
                    name: ""
                },
                numberOfUsers: 0,
                resultStatistic: "",
                gameCode: "",
                afterGameMessage: 'The game is finished. Thank You!'

            }
        },
        mounted() {
            this.TriggerNextQuestionEvent();
        },
        methods: {
            TriggerNextQuestionEvent() {
                if(!this.personal){
                    Echo.private('new-question')
                        .listen('QuestionEvent', (e) => {
                            if(e.question.user_id!==this.user_id){
                                this.questionsPusher.push(e.question.question_id);
                                this.nextQuestion(e.question);

                            }
                        });

                    Echo.join('new-question')
                        .here((users) => {
                            //this.numberOfUsers = users.length;
                        })
                        .joining((user) => {
                            this.numberOfUsers += 1;
                            this.$toaster.success(user.name + ' joined the game.');
                        })
                        .leaving((user) => {
                            if(this.numberOfUsers>0){
                                this.numberOfUsers -= 1;
                            }

                            this.$toaster.info(user.name + ' left the game.');
                        });
                }
            },
            PrepareGame(title) {
                let timerInterval
                var self = this;
                Swal({
                    title: title,
                    html: 'Game preparation is in process...<br> Your game will be ready in <strong></strong> seconds.',
                    timer: 5000,
                    //-- Disable manually deactivate modal
                    allowOutsideClick: false,
                    onOpen: () => {
                        Swal.showLoading()
                        timerInterval = setInterval(() => {
                            Swal.getContent().querySelector('strong')
                                .textContent = Math.round(Swal.getTimerLeft() / 1000)
                        }, 100)
                    },
                    onClose: () => {
                        clearInterval(timerInterval)
                    }
                }).then((result) => {
                    if (
                        // Read more about handling dismissals
                    result.dismiss === Swal.DismissReason.timer
                    ) {
                        self.currentQuestion = self.questions[self.currentQuestionID];
                        bus.$emit('nextQuestionAgain', !this.gameFinished);
                        bus.$emit('restTimeOutErrorNotification', true);
                    }
                });
            },
            GetListOfSelectedQuestions() {
                axios.post(route('get_game_data'), {
                    game_id: this.id,
                }).then(response => {
                    if (response['data']['result'] === "success") {
                        this.game.title = response['data']['game'].title;
                        this.game.id = response['data']['game'].id;
                        this.game.user_id = response['data']['game'].user_id;

                        //-- Get current generated group game code
                        if(!this.personal){
                            this.gameCode=response['data']['game_code'];
                        }

                        if (response['data']['game'].questions.length > 0) {
                            this.questions = response['data']['game'].questions;
                            for (var i = 0; i < this.questions.length; i++) {
                                this.questionNames[this.questions[i].id] = this.questions[i].question
                            }
                        } else {
                            this.questions = [];
                            var arrConfig = {
                                result: '',
                                status: false
                            };
                            this.nextQuestion(arrConfig);
                        }

                    } else {
                        //-- Destroy event listener from previous question
                        bus.$off('nextQuestionAgain');
                        //this.$toaster.error(response['data']['error']);
                    }
                }).catch(error => {
                    console.log(error);
                });
            },
            saveResult(data) {
                this.result.answers.push(data.answer_id);
                this.result.questions.push(data.question_id);
                this.result.status.push(data.correct);
                this.result.time.push(data.time);
            },
            getResult() {
                var result = this.result;
                if(!this.personal){
                    for(var i=0;i<this.questionsPusher.length;i++){
                        if(this.questionsPusher[i]!==undefined && !this.result.questions.includes(this.questionsPusher[i])){
                            this.result.answers.push(0);
                            this.result.questions.push(this.questionsPusher[i]);
                            this.result.status.push(false);
                            this.result.time.push(0);
                        }
                    }
                }
                if(this.result.status.length>0){
                    var count=0;

                    for(var i=0;i<this.result.status.length;i++){
                        if(this.result.status[i]){
                            count++;
                        }
                    }

                    this.resultStatistic=count+" from "+this.result.status.length;
                }

                this.saveResultInDB(this.result);
                this.result = {};
                return result;
            },
            saveResultInDB(data) {
                axios.post(route('save_result'), {
                    data: data,
                    game_id: this.game.id,
                    game_type: this.personal,
                    game_code: this.gameCode
                }).then(response => {
                    this.$toaster.success('Game results were successfully saved!');
                }).catch(error => {
                    console.log(error);
                });
            },
            nextQuestion(data) {
                if (data.status && this.currentQuestionID < (this.questions.length - 1)) {
                    this.currentQuestionID += 1;
                    this.currentQuestion = this.questions[this.currentQuestionID];
                    bus.$emit('nextQuestionAgain', !this.gameFinished);

                } else {
                    this.gameFinished = true;
                    //-- Destroy event listener from previous question
                    bus.$off('nextQuestionAgain');
                    bus.$off('triggerNextQuestionManually');

                    //-- Hide question popup timer
                    var timerPopup = document.getElementById('timerPopup');
                    if (timerPopup) {
                        timerPopup.style.display = 'none';
                    }

                    if (!data.status) {
                        this.afterGameMessage = 'This game has no questions';
                        this.$toaster.error('This game has no questions');
                    } else {
                        this.finalResult = this.getResult();
                        this.$toaster.success('CONGRATULATIONS! The game is finished');

                        //-- Get results of other players of this game
                        if(!this.personal){
                            setTimeout(() => this.getGroupGameOtherResults(), 2000);
                        }
                    }
                }
            },
            getGroupGameOtherResults(){
                axios.post(route('get_group_game_results'), {
                    game_type: this.personal,
                    game_code: this.gameCode
                }).then(response => {
                    if(response['data']['result']==='success'){
                        for(var i=0;i<response['data']['data'].length;i++){

                            if(this.otherGameResults[response['data']['data'][i]['user_id']] === undefined){
                                this.otherGameResults[response['data']['data'][i]['user_id']]=0;
                            }
                            if(this.otherGameUserQuestionsPlayed[response['data']['data'][i]['user_id']]=== undefined){
                                this.otherGameUserQuestionsPlayed[response['data']['data'][i]['user_id']]=0;
                            }

                            if(response['data']['data'][i]['status']==='Y'){
                                this.otherGameResults[response['data']['data'][i]['user_id']] +=1;
                            }
                            this.otherGameUserQuestionsPlayed[response['data']['data'][i]['user_id']] +=1;
                        }
                        this.allUsers=response['data']['users'];
                    }
                    this.$toaster.success('Game results are successfully generated!');
                }).catch(error => {
                    console.log(error);
                });
            },
            PlayAgain() {
                location.reload();

                //-- Destroy event listener from previous question
                bus.$off('nextQuestionAgain');
            }
        },
        created() {

            this.PrepareGame(this.title);
            this.GetListOfSelectedQuestions();

            //-- Trigger manually next question
            bus.$on('triggerNextQuestionManually', (data) => {
                if (data) {

                    //-- Trigger laravel event for Pusher
                    axios.post(route('trigger_event'), {
                        game_id: this.game.id,
                        user_id: this.user_id,
                        question_id: this.currentQuestion.id
                    }).then(response => {
                        //this.$toaster.success('Trigger Pusher event!');
                    }).catch(error => {
                        console.log(error);
                    });

                    var arrConfig = {
                        result: '',
                        status: true
                    };
                    this.nextQuestion(arrConfig);
                }
            });


            //-- Destroy event listener from previous question
            bus.$off('nextQuestionAgain');
        }
    }
</script>

<style scoped>

</style>