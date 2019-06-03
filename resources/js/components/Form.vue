<template>
    <div>
        <div class="form-group">
            <input type="text" class="form-control" id="question_title" placeholder="Question title" @keyup="ValidateError" v-model="question.title">
            <span class="w3-text-red">{{errors.title}}</span>
            <p v-if="question.title" v-bind:style="styleObject">
                <span class="info">You question is:</span>
                {{question.title}}
            </p>
            <p v-else class="info">No title provided</p>
        </div>

        <div class="row">
            <div class="col">
                <div class="form-group">
                    <label for="answer_one">First answer</label>
                    <input type="radio" value="1" v-model="correctAnswer" @click="ValidateError">
                    <input type="text" class="form-control" id="answer_one" :placeholder="answer_placeholder" @keyup="ValidateError" v-model="answers.answer_1">
                    <span class="w3-text-red">{{errors.answer_1}}</span>
                </div>
            </div>
            <div class="col">
                <div class="form-group">
                    <label for="answer_two">Second answer</label>
                    <input type="radio" value="2" v-model="correctAnswer" @click="ValidateError">
                    <input type="text" class="form-control" id="answer_two" :placeholder="answer_placeholder" @keyup="ValidateError" v-model="answers.answer_2">
                    <span class="w3-text-red">{{errors.answer_2}}</span>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <div class="form-group">
                    <label for="answer_three">Third answer</label>
                    <input type="radio" value="3" v-model="correctAnswer" @click="ValidateError">
                    <input type="text" class="form-control" id="answer_three" :placeholder="answer_placeholder" @keyup="ValidateError" v-model="answers.answer_3">
                    <span class="w3-text-red">{{errors.answer_3}}</span>
                </div>
            </div>
            <div class="col">
                <div class="form-group">
                    <label for="answer_four">Fourth answer</label>
                    <input type="radio" value="4"  v-model="correctAnswer" @click="ValidateError">
                    <input type="text" class="form-control" id="answer_four" :placeholder="answer_placeholder" @keyup="ValidateError" v-model="answers.answer_4">
                    <span class="w3-text-red">{{errors.answer_4}}</span>
                </div>
            </div>
        </div>

        <button class="btn btn-success" @click="SaveQuestion">
            Send
        </button>
    </div>
</template>

<script>
    import {bus} from '../app'
    export default {
        name: "form-item",
        props: ['id'],
        data() {
            return {
                question:{
                    title:"",
                    user_id:arrVueConfig['user_id']
                },
                answer_placeholder:"Type answer",
                answers:{
                    answer_1:"",
                    answer_2:"",
                    answer_3:"",
                    answer_4:""
                },
                errors:{
                    title:"",
                    answer_1:"",
                    answer_2:"",
                    answer_3:"",
                    answer_4:""
                },
                actionBar:{
                    showQuestionBtn:true,
                    goToList:false,
                    goToGameList:true,
                    newGame:true
                },
                errorMessage:"",
                correctAnswer: "",
                styleObject:{
                    color:"red",
                    fontSize:"30px"
                },
                checked: true,
                formValidateStatus: true
            }
        },
        methods: {
            ValidateError(){
                if(this.question.title!=""){
                    this.errors.title='';
                }
                for(var i=1;i<=4;i++){
                    if(this.answers['answer_'+i]!=""){
                        this.formValidateStatus=false;
                        this.errors['answer_'+i]='';

                    }
                }
                this.formValidateStatus=true;
            },
            SaveQuestion(){

                if(this.question.title==""){
                    this.formValidateStatus=false;
                    var error='Title field is required';
                    this.errors.title='*'+error;
                    this.errorMessage=error;
                    this.$toaster.error(this.errorMessage);
                }

                for(var i=1;i<=4;i++){
                    if(this.answers['answer_'+i]==""){
                        this.formValidateStatus=false;
                        var error='Answer '+i+' is required field';
                        this.errors['answer_'+i]='*'+error;
                        this.errorMessage=error;
                        this.$toaster.error(this.errorMessage);
                    }
                }


                //-- Check if at least one answer is marked as 'Correct answer'
                if(+this.correctAnswer<=0){
                        this.formValidateStatus=false;
                        var error='At least one answer should be marked as \'Correct answer\'';
                        this.errors['answer_'+i]='*'+error;
                        this.errorMessage=error;
                        this.$toaster.error(this.errorMessage);
                }


                if(this.formValidateStatus){

                    axios.post(route('save_question'), {
                        question: this.question.title,
                        correctAnswer: this.correctAnswer,
                        answers: this.answers,
                    }).then(response => {

                        if(response['data']['result']=== "success"){
                            this.$toaster.success('question was successfully created');
                            bus.$emit('showQuestionsList',this.actionBar);
                        }

                    }).catch(error => {
                        console.log(error);
                    });
                }

            }
        },
        created(){

           if(+this.id>0){
               axios.post(route('get_question_data'), {
                   question_id: this.id,
               }).then(response => {

                   if(response['data']['result']=== "success"){
                       this.question.title=response['data']['question'].question;
                       for(var i=0;response['data']['question'].answers.length;i++){

                            if(response['data']['question'].answers[i].status=='Y'){
                                this.correctAnswer=i+1;
                            }
                           this.answers['answer_'+(i+1)]=response['data']['question'].answers[i].answer;
                       }
                       this.answers.answer_1=response['data']['question'].question;
                   }else{
                       //this.$toaster.error(response['data']['error']);
                   }
               }).catch(error => {
                   console.log(error);
               });
           }
        }
    }
</script>

<style scoped>
    .info{
        color: gray;
        font-size: 20px;
    }
    .selected { border: 1px solid red; }
</style>