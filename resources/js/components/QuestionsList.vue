<template>
    <div class="list_container">
        <div class="row">
            <div class=" col">
                <search-bar @search="searchItems"></search-bar>
            </div>
        </div>
        <hr>
        <div v-if="filteredQuestions.length>0">
        <question-item v-for="q in filteredQuestions"
        :question="q.question"
        :answers="q.answers"
        :id="q.id"
        :created_at="q.created_at"
        :checkbox="'N'"
        :key="q.id"
        ></question-item>
        </div>
        <div v-else>No questions found</div>
        <div class="w3-display-container pagination_box">
            <paginate class="w3-display-topmiddle"
                      v-model="page"
                      :page-count="showPagination?Math.ceil(pageCount):Math.ceil(listQuestions.length/3)"
                      :margin-pages="2"
                      :page-range="3"
                      :container-class="'pagination'"
                      :page-class="'page-item'"
                      :page-link-class="'page-link-item'"
                      :prev-class="'prev-item'"
                      :prev-link-class="'prev-link-item'"
                      :next-class="'next-item'"
                      :next-link-class="'next-link-item'"
                      :break-view-class="'break-view'"
                      :break-view-link-class="'break-view-link'"
                      :first-last-button="true"
                      :click-handler="filterPaginationList"
            ></paginate>
        </div>
    </div>

</template>

<script>
    import {bus} from '../app';
    export default {
        name: "questions-list",
        data() {
            return {
               title:"This title list",
                questions:[],
                allQuestions:[],
                listQuestions:[],
                user_id:arrVueConfig['user_id'],
                search:"",
                page: 1,
                showPagination:true
            }
        },
        computed:{
            filteredQuestions:{
                get: function () {
                    if(this.search!="" ){

                        this.showPagination=false;

                            this.listQuestions=this.allQuestions.filter((question) => {
                                return question.question.toLowerCase().match(this.search.toLowerCase());
                            });
                        return this.filterPaginationList(this.page);
                    }else{
                        this.showPagination=true;
                         this.questions.filter((question)=>{
                                return question.question.toLowerCase().match(this.search.toLowerCase());
                            });
                        return this.filterPaginationList(this.page);
                    }
                },
                // setter
                set: function (newValue) {

                }


            },

            pageCount:function(){
                return this.allQuestions.length/3;
            }
        },
        methods:{
            filterPaginationList: function(pageNum) {
                pageNum=Math.ceil(pageNum);

                var arrTemp = [];
                var start=0;
                if(pageNum>1){
                    start=(pageNum-1)*3
                }

                for (var i=start; i<(start+3); i++){
                    if(this.search!="" ){
                        if(i<this.listQuestions.length){
                            arrTemp.push(this.listQuestions[i]);
                        }
                    }else{
                        if(i<this.allQuestions.length){
                            arrTemp.push(this.allQuestions[i]);
                        }
                    }
                }



                this.questions=arrTemp;
                return arrTemp;
            },
            searchItems(search){
                this.page=1;
                this.search=search;
            },
            FilterQuestionsList(id){
                var arrTemp=[];
                for(var i=0;i<this.allQuestions.length;i++){
                    if(this.allQuestions[i].id !== +id){
                        arrTemp.push(this.allQuestions[i]);
                    }
                }
                this.allQuestions=arrTemp;
            },
            GetListOfQuestions(){
                axios.post(route('get_question_list'), {
                    user_id: this.user_id,
                    filtered: false,
                    game_id: 0
                }).then(response => {
                    if(response['data']['result']=== "success"){
                        this.questions=response['data']['questions'];
                        this.allQuestions=response['data']['questions'];
                        this.filterPaginationList(this.page);
                    }else{
                        //this.$toaster.error(response['data']['error']);
                    }
                }).catch(error => {
                    console.log(error);
                });
            }
        },
        created(){
            this.GetListOfQuestions();

            //-- Reset searching bar value
            bus.$on('resetSearch', (data)=>{
                if(data){
                    this.search="";
                }
            });
            bus.$on('deleteQuestion', (data)=>{
                this.page=1;
                this.FilterQuestionsList(data);
            });

            //-- Reset buttons in ActionBar component
            bus.$on('resetQuestionListCache', (data)=>{
                if(data.status){
                    this.GetListOfQuestions();
                    bus.$emit('resetButtons',data.actionBar);
                }
            });
        }
    }
</script>

<style scoped>
    .pagination_box{
        top:-40px;
    }
    .list_container{
        padding-bottom: 30px;
    }
</style>