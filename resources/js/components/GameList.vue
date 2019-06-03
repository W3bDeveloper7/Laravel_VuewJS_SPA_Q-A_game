<template>
    <div class="list_container">
        <div class="row">
            <div class=" col">
                <button class="btn btn-sm w3-green" v-if="showMyGamesButton" @click="ShowOnlyMyGames">Show only my
                    games
                </button>
                <button class="btn btn-sm w3-blue" v-if="!showMyGamesButton" @click="ShowAllGames">Show all games
                </button>
            </div>
            <div class=" col">
                <search-bar @search="searchItems"></search-bar>
            </div>
        </div>
        <hr>
        <div v-if="filteredGames.length>0">
            <game-item v-for="g in filteredGames"
                       :title="g.title"
                       :id="g.id"
                       :user_id="g.user_id"
                       :created_at="g.created_at"
                       :key="g.id"
            ></game-item>
            <div class="w3-display-container pagination_box">
                <paginate class="w3-display-topmiddle"
                        v-model="page"
                        :page-count="showPagination?Math.ceil(pageCount):Math.ceil(listGames.length/3)"
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
        <div v-else>No games found</div>
    </div>
</template>

<script>
    import {bus} from '../app';

    export default {
        name: "game-list",
        data() {
            return {
                page: 1,
                games: [],
                allGames: [],
                allMyGames: [],
                listGames: [],
                user_id: arrVueConfig['user_id'],
                showMyGamesButton: true,
                search:"",
                showPagination:true
            }
        },
        methods: {
            filterPaginationList: function(pageNum) {
                pageNum=Math.ceil(pageNum);

                var arrTemp = [];
                var start=0;
                if(pageNum>1){
                    start=(pageNum-1)*3
                }

                for (var i=start; i<(start+3); i++){
                    if(this.search!="" ){
                            if(i<this.listGames.length){
                                arrTemp.push(this.listGames[i]);
                        }
                    }else{
                        if(this.showMyGamesButton){

                            if(i<this.allGames.length){
                                arrTemp.push(this.allGames[i]);
                            }
                        }else{
                            if(i<this.allMyGames.length){
                                arrTemp.push(this.allMyGames[i]);
                            }
                        }
                    }
                }

                this.games=arrTemp;

                return arrTemp;
            },
            searchItems(search){
                    this.page=1;
                this.search=search;
            },
            ShowOnlyMyGames() {
                this.page=1;
                var arrTemp = [];
                for (var i = 0; i < this.games.length; i++) {
                    if (this.games[i].user_id == this.user_id) {
                        arrTemp.push(this.games[i]);
                    }
                }
                this.games = arrTemp;
                this.showMyGamesButton = false;

                bus.$emit('changePageTitle', "My games list");
                this.filterPaginationList(this.page);
            },
            ShowAllGames() {
                this.page=1;
                this.games = this.allGames;
                this.showMyGamesButton = true;
                bus.$emit('changePageTitle', "All games list");
                this.filterPaginationList(this.page);
            },
            FilterGamesList(id) {
                var arrTemp = [];
                for (var i = 0; i < this.allGames.length; i++) {
                    if (this.allGames[i].id !== +id) {
                        arrTemp.push(this.allGames[i]);
                    }
                }
                this.allGames = arrTemp;
            },
            GetListOfGames() {
                axios.post(route('get_games_list'), {
                    // user_id: this.user_id,
                }).then(response => {
                    if (response['data']['result'] === "success") {
                        var arrTemp = [];
                        //-- Filter games for showing only allowed games
                        for (var i = 0; i < response['data']['games'].length; i++) {
                            if(+response['data']['games'][i].for_specific_user!==0){
                                if(+response['data']['games'][i].for_specific_user===this.user_id || this.user_id===+response['data']['games'][i].user_id) {
                                    arrTemp.push(response['data']['games'][i]);
                                }
                            }else{
                                arrTemp.push(response['data']['games'][i]);
                            }
                        }
                        this.games = arrTemp;
                        this.allGames = this.games;
                        var arrTemp = [];
                        for (var i = 0; i < this.games.length; i++) {
                            if (this.games[i].user_id == this.user_id) {
                                arrTemp.push(this.games[i]);
                            }
                        }
                        this.allMyGames = arrTemp;


                        this.filterPaginationList(this.page);
                    } else {
                        //this.$toaster.error(response['data']['error']);
                    }
                }).catch(error => {
                    console.log(error);
                });
            }
        },
        computed:{
            filteredGames:{
                get: function () {
                    if(this.search!="" ){

                        this.showPagination=false;
                        if(this.showMyGamesButton) {
                            this.listGames=this.allGames.filter((game) => {
                                return game.title.toLowerCase().match(this.search.toLowerCase());
                            });

                        }else{
                            this.listGames=this.allMyGames.filter((game) => {
                                return game.title.toLowerCase().match(this.search.toLowerCase());
                            });
                        }

                        return this.filterPaginationList(this.page);
                    }else{
                        this.showPagination=true;
                        this.games.filter((game)=>{
                                return game.title.toLowerCase().match(this.search.toLowerCase());
                        });
                        return this.filterPaginationList(this.page);
                    }
                },
                // setter
                set: function (newValue) {

                }
            },
            pageCount:function(){
                if(this.showMyGamesButton) {
                    return this.allGames.length / 3;
                }else{
                    return this.allMyGames.length / 3;
                }
            }
        },
        created() {
            this.GetListOfGames();

            //-- Reset buttons in ActionBar component
            bus.$on('resetGameListCache', (data) => {
                if (data.status) {
                    this.GetListOfGames();
                    bus.$emit('resetButtons', data.actionBar);
                }
            });

            //-- Reset searching bar value
            bus.$on('resetSearch', (data)=>{
                if(data){
                    this.search="";
                }
            });

            bus.$on('deleteGame', (data) => {
                this.page=1;
                this.FilterGamesList(data);
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