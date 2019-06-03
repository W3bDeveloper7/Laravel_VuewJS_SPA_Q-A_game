<template>
    <div>
        <div class="form-group">
            <input type="text" class="form-control" id="game_title" placeholder="Game title" @keyup="ValidateError"
                   v-model="game.title">
            <span class="w3-text-red">{{errors.title}}</span>
        </div>
        <div class="form-group">
            <label for="selectUser">Choose specific user(In that case this game will be seen only for this user)</label>
            <select id="selectUser" class="form-control" v-model="selectedUser">
                <option value="0"></option>
                <option v-for="user in users" :value="user.id">{{user.name}}</option>
            </select>
        </div>
        <button class="btn btn-success w3-margin-bottom" @click="SaveGame">
            Send
        </button>
        <tabs v-if="showAllTabs">
            <tab-item name="Selected Questions" :selected="true">
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
                                   :checkbox="'Y'"
                                   :status="true"
                                   :game_id="game.id"
                                   :key="q.id"
                    ></question-item>
                </div>
                <div v-else>No selected questions found</div>
            </tab-item>
            <tab-item name="Other Questions">
                <div class="row">
                    <div class=" col">
                        <search-bar @search="searchItems"></search-bar>
                    </div>
                </div>
                <hr>
                <div v-if="filteredQuestionsOther.length>0">
                    <question-item v-for="qa in filteredQuestionsOther"
                                   :question="qa.question"
                                   :answers="qa.answers"
                                   :id="qa.id"
                                   :created_at="qa.created_at"
                                   :checkbox="'Y'"
                                   :status="false"
                                   :game_id="game.id"
                                   :key="qa.id"
                    ></question-item>
                </div>
                <div v-else>No questions found</div>
                <div class="w3-display-container pagination_box">
                    <paginate class="w3-display-topmiddle"
                              v-model="page"
                              :page-count="showPagination?Math.ceil(pageCountOther):Math.ceil(listQuestionsOther.length/3)"
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
                              :click-handler="filterPaginationListOther"
                    ></paginate>
                </div>
            </tab-item>

        </tabs>
        <tabs v-else>
            <tab-item name="Other Questions" :selected="true">
                <div class="row">
                    <div class=" col">
                        <search-bar @search="searchItems"></search-bar>
                    </div>
                </div>
                <hr>
                <div v-if="filteredQuestionsOther.length>0">
                    <question-item v-for="qa in filteredQuestionsOther"
                                   :question="qa.question"
                                   :answers="qa.answers"
                                   :id="qa.id"
                                   :created_at="qa.created_at"
                                   :checkbox="'Y'"
                                   :status="false"
                                   :game_id="game.id"
                                   :key="qa.id"
                    ></question-item>
                </div>
                <div v-else>No questions found</div>
                <div class="w3-display-container pagination_box">
                    <paginate class="w3-display-topmiddle"
                              v-model="page"
                              :page-count="showPagination?Math.ceil(pageCountOther):Math.ceil(listQuestionsOther.length/3)"
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
                              :click-handler="filterPaginationListOther"
                    ></paginate>
                </div>
            </tab-item>

        </tabs>

    </div>
</template>

<script>
    import {bus} from '../app';

    export default {
        name: "game-form",
        props: ['id'],
        data() {
            return {
                game: {
                    title: "",
                    id: ""
                },
                user_id: arrVueConfig['user_id'],
                answer_placeholder: "Type answer",
                errors: {
                    title: ""
                },
                users:{},

                questions: [],
                allQuestions: [],
                listQuestions: [],

                questionsOther: [],
                allQuestionsOther: [],
                listQuestionsOther: [],


                actionBar: {
                    showQuestionBtn: true,
                    goToList: true,
                    goToGameList: false,
                    newGame: true,
                },
                errorMessage: "",
                styleObject: {
                    color: "red",
                    fontSize: "30px"
                },
                checked: true,
                formValidateStatus: true,
                updateCache: false,
                search: "",
                page: 1,
                showPagination: true,
                removeItemFromList: false,
                selectedUser: 0
            }
        },
        computed: {

            pageCount: function () {
                return this.allQuestions.length / 3;
            },
            pageCountOther: function () {
                return this.allQuestionsOther.length / 3;
            },
            showAllTabs: function () {
                if (this.game.id > 0) {
                    return true;
                }
                return false;
            },
            filteredQuestions: {
                get: function () {
                    if (this.search != "") {
                        return this.allQuestions.filter((question) => {
                            return question.question.toLowerCase().match(this.search.toLowerCase());
                        });

                    } else {
                         this.questions.filter((question) => {
                            return question.question.toLowerCase().match(this.search.toLowerCase());
                        });

                        return this.questions;
                    }
                },
                // setter
                set: function (newValue) {

                }
            },
            filteredQuestionsOther: {
                get: function () {
                    if (this.search != "") {

                        this.showPagination = false;

                        this.listQuestionsOther = this.allQuestionsOther.filter((question) => {
                            return question.question.toLowerCase().match(this.search.toLowerCase());
                        });

                        return this.filterPaginationListOther(this.page);
                    } else {


                        this.showPagination = true;
                        this.questionsOther.filter((question) => {
                            return question.question.toLowerCase().match(this.search.toLowerCase());
                        });

                        return this.filterPaginationListOther(this.page);
                    }
                },
                // setter
                set: function (newValue) {

                }
            }

        },
        methods: {
            filterPaginationListOther: function (pageNum) {
                pageNum = Math.ceil(pageNum);

                var arrTemp = [];
                var start = 0;
                if (pageNum > 1) {
                    start = (pageNum - 1) * 3
                }

                for (var i = start; i < (start + 3); i++) {
                    if (this.search != "") {
                        if (i < this.listQuestionsOther.length) {
                            arrTemp.push(this.listQuestionsOther[i]);
                        }
                    } else {
                        if (!this.removeItemFromList) {
                            if (i < this.allQuestionsOther.length) {
                                arrTemp.push(this.allQuestionsOther[i]);
                            }
                        } else {
                            if (i < this.allQuestionsOther.length) {
                                arrTemp.push(this.questionsOther[i]);
                            }
                            this.removeItemFromList=false;
                        }
                    }
                }

                this.questionsOther = arrTemp;
                return arrTemp;
            },
            searchItems(search) {
                this.page = 1;
                this.search = search;
            },
            ValidateError() {
                if (this.game.title != "") {
                    this.errors.title = '';
                }

                this.formValidateStatus = true;
            },

            SaveGame() {
                if (this.game.title == "") {
                    this.formValidateStatus = false;
                    var error = 'Title field is required';
                    this.errors.title = '*' + error;
                    this.errorMessage = error;
                    this.$toaster.error(this.errorMessage);
                }
                if (this.formValidateStatus) {

                    //-- Get currently selected elements
                    var arrSelectedItems = sessionStorage.getItem("selectedQuestionIDs");

                    if (arrSelectedItems == null) {
                        arrSelectedItems = false;
                    }
                    axios.post(route('save_game'), {
                        title: this.game.title,
                        id: this.game.id,
                        arrSelectedItems: arrSelectedItems,
                        selectedUser: this.selectedUser
                    }).then(response => {
                        if (response['data']['result'] === "success") {
                            if (this.game.id != "") {
                                var strAction = "created";
                            } else {
                                var strAction = "updated";
                            }
                            this.$toaster.success('Game was successfully ' + strAction);
                            bus.$emit('goToGamesList', this.actionBar);
                        }

                    }).catch(error => {
                        console.log(error);
                    });
                }

            },
            GetListOfSelectedQuestions() {
                axios.post(route('get_game_data'), {
                    game_id: this.id,
                }).then(response => {
                    if (response['data']['result'] === "success") {
                        this.game.title = response['data']['game'].title;
                        this.game.id = response['data']['game'].id;
                        this.selectedUser = response['data']['game'].for_specific_user;

                        if (response['data']['game'].questions.length > 0) {
                            this.questions = response['data']['game'].questions;
                            this.allQuestions = response['data']['game'].questions;
                        } else {
                            this.questions = [];
                        }
                    } else {
                        //this.$toaster.error(response['data']['error']);
                    }
                }).catch(error => {
                    console.log(error);
                });
            },
            GetListOfOtherQuestions() {
                axios.post(route('get_question_list'), {
                    user_id: this.user_id,
                    filtered: true,
                    game_id: this.id
                }).then(response => {
                    if (response['data']['result'] === "success") {
                        this.questionsOther = response['data']['questions'];
                        this.allQuestionsOther = response['data']['questions'];
                        this.filterPaginationListOther(this.page);

                        for(var i=0;i<response['data']['users'].length;i++){
                            this.users[response['data']['users'][i].id]=response['data']['users'][i];
                        }

                    } else {
                        this.questionsOther = [];
                        //this.$toaster.error(response['data']['error']);
                    }
                }).catch(error => {
                    console.log(error);
                });
            },
            FilterQuestionsList(id, type) {
                var arrTemp = [];
                if (type == 'selected') {
                    for (var i = 0; i < this.questions.length; i++) {
                        if (this.questions[i].id !== +id) {
                            arrTemp.push(this.questions[i]);
                        }
                    }
                    this.questions = arrTemp;
                    this.GetListOfOtherQuestions();

                } else {
                    for (var i = 0; i < this.allQuestionsOther.length; i++) {
                        if (this.allQuestionsOther[i].id !== +id) {
                            arrTemp.push(this.allQuestionsOther[i]);
                        }
                    }

                    this.GetListOfSelectedQuestions();
                    this.allQuestionsOther = arrTemp;
                }
            }
        },
        created() {
            if (+this.id > 0) {
                this.GetListOfSelectedQuestions();
            }
            this.GetListOfOtherQuestions();


            bus.$on('removeQuestionFromTheList', (data) => {
                this.removeItemFromList = true;
                    this.FilterQuestionsList(data.id, data.type);
            });

            //-- Reset searching bar value
            bus.$on('resetSearch', (data) => {
                if (data) {
                    this.search = "";
                }
            });


        }
    }
</script>

<style scoped>

</style>