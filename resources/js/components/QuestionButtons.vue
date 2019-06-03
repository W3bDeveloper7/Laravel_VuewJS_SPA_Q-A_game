<template>
    <div>
        <button class="butn btn w3-green" @click="editQuestion" v-tooltip.bottom="'Edit question'"><i class="fas fa-edit"></i></button>
        <button class="butn btn w3-red" v-if="statusDeleteButton" @click="deleteQuestion" v-tooltip.bottom="'Delete question'"><i class="fas fa-trash-alt"></i></button>
        <button class="butn btn w3-blue" v-tooltip.right="infoAboutAnswers"><i class="fas fa-info-circle"></i></button>
        <input type="checkbox" v-if="checkbox=='Y'"  v-model="checked" @change="AddOrDeleteQuestionToGame"
               :value="id">
    </div>
</template>

<script>
    import {bus} from '../app';
    import Swal from 'sweetalert2';
    export default {
        name: "question-buttons",
        props: ['id','checkbox','status','game_id','answers'],
        data() {
            return {
                actionBar:{
                    showQuestionBtn:true,
                    goToList:false,
                    goToGameList:true
                },
                checked:true,
                arrSelectedQuestionIDs:[],
                statusDeleteButton:true,
            }
        },
        computed: {
            infoAboutAnswers: function () {
                var resultAnswers="All answers<br>";
                if(this.answers!==undefined && this.answers.length>0){
                    for(var i=0;i<this.answers.length;i++){
                        var strCorrect="";
                        if(this.answers[i].status=="Y"){
                            strCorrect="(correct)";
                        }
                        resultAnswers += (i+1)+") "+this.answers[i].answer+" "+strCorrect+"<br>";
                    }
                }
                return resultAnswers;
            },
        },
        methods:{
            AddOrDeleteQuestionToGame(){
                if(this.game_id>0){
                    axios.post(route('update_game_questions'), {
                        game_id: this.game_id,
                        question_id: this.id,
                        status:this.checked
                    }).then(response => {

                        if(response['data']['result']=== "success"){
                            if(this.checked){
                                var arrConfig={
                                    id:this.id,
                                    status:'delete',
                                    type:'other'
                                };
                                bus.$emit('removeQuestionFromTheList',arrConfig);
                                this.$toaster.success('Question was successfully added to this game');
                            }else{
                                var arrConfig={
                                    id:this.id,
                                    status:'delete',
                                    type:'selected'
                                };
                                bus.$emit('removeQuestionFromTheList',arrConfig);
                                this.$toaster.error('Question was removed from this game');
                            }
                        }else{
                            this.checked=false;
                            this.$toaster.error(response['data']['error']);
                        }
                    }).catch(error => {
                        console.log(error);
                    });
                }else{
                    //-- Remove element from array by value
                    Array.prototype.remove = function() {
                        var what, a = arguments, L = a.length, ax;
                        while (L && this.length) {
                            what = a[--L];
                            while ((ax = this.indexOf(what)) !== -1) {
                                this.splice(ax, 1);
                            }
                        }
                        return this;
                    };

                    //-- Remove empty strings from array
                    Array.prototype.clean = function(deleteValue) {
                        for (var i = 0; i < this.length; i++) {
                            if (this[i] == deleteValue) {
                                this.splice(i, 1);
                                i--;
                            }
                        }
                        return this;
                    };
                    
                    var arrSelectedItems=[];
                    var strSelectedItems=sessionStorage.getItem("selectedQuestionIDs");

                    if(strSelectedItems!=null){
                        arrSelectedItems=strSelectedItems.split(',');
                    }
                    arrSelectedItems.clean("");
                    if(this.checked){
                        arrSelectedItems.push(this.id.toString());
                    }else{
                        arrSelectedItems.remove(this.id.toString());
                    }

                    //-- Check if quantity of questions is in allowed limit
                    if(arrSelectedItems.length<=10){
                        sessionStorage.setItem('selectedQuestionIDs', arrSelectedItems);
                    }else{
                        this.checked=false;
                        this.$toaster.error('WARNING! Max 10 questions are allowed in one game!');
                    }

                }
            },
            deleteQuestion(){
                let deleteStatus=false;
                var self = this;
                Swal({
                    title: 'Do you really want to delete this question?',
                    text: "Question and all related answers will be deleted permanently",
                    type: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Yes, delete it!',
                    cancelButtonText: 'No, cancel!',
                    confirmButtonClass: 'btn btn-success',
                    cancelButtonClass: 'btn btn-danger',
                    buttonsStyling: false
                }).then(function (result) {

                    if(result.dismiss=='cancel'){
                        Swal(
                                    'Cancelled',
                                    'Question won\'t be deleted :)',
                                    'info'
                                )
                        deleteStatus=false;
                    }else if(result.value){
                        Swal(
                            'Deleted!',
                            'Question has been deleted.',
                            'success'
                        );

                        //-- Set delete Status to true
                        deleteStatus=true;

                        //-- Functionality to delete specific question
                        axios.post(route('delete_question'), {
                            id: self.id,
                        }).then(response => {
                            if(response['data']['result']=== "success"){
                                self.$toaster.error('Question was successfully deleted');
                            }
                        }).catch(error => {
                            console.log(error);
                        });
                    }

                    //-- Return promise value for next validation
                    return  deleteStatus;

                }).then(function (result) {
                        if(result){
                            bus.$emit('deleteQuestion',self.id);
                        }
                });
            },
            editQuestion(){
                this.actionBar.showQuestionBtn=false;
                this.actionBar.goToList=true;
                this.actionBar.id=this.id;
                bus.$emit('addQuestion', this.actionBar);
            }
        },
        created(){

            //-- Remove empty strings from array
            Array.prototype.clean = function(deleteValue) {
                for (var i = 0; i < this.length; i++) {
                    if (this[i] == deleteValue) {
                        this.splice(i, 1);
                        i--;
                    }
                }
                return this;
            };
            var arrSelectedItems=[];
            var strSelectedItems=sessionStorage.getItem("selectedQuestionIDs");

            if(strSelectedItems!=null){
                arrSelectedItems=strSelectedItems.split(',');
            }
            arrSelectedItems.clean("");

            if(!this.status && !arrSelectedItems.includes(this.id.toString())){
                this.checked=false;
            }

            //-- Check if necessary to display delete button
            if(this.status!==undefined){
                this.statusDeleteButton=false;
            }

        }
    }
</script>

<style scoped>
    .butn{
        border-radius: 20px;
        width:40px;
        height:40px;
    }
</style>