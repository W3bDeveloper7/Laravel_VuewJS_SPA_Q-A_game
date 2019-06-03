<template>
    <div>
        <button class="butn btn w3-green" v-if="user_id==current_user_id" @click="editGame" v-tooltip.bottom="'Edit game'"><i class="fas fa-edit"></i></button>
        <button class="butn btn w3-red w3-margin-right" v-if="user_id==current_user_id" @click="deleteGame" v-tooltip.bottom="'Delete game'"><i class="fas fa-trash-alt"></i></button>
        <router-link :to="{ name: 'game_personal', params: { id: id }}" class="butn btn w3-orange" v-tooltip.bottom="'Start personal game'"><i class="far fa-eye"></i></router-link>
        <router-link :to="{ name: 'game_group', params: { id: id }}" class="butn btn w3-blue"  v-tooltip.bottom="'Start group game'"><i class="fab fa-quinscape"></i></router-link>
    </div>
</template>


<script>
    import {bus} from '../app';
    import Swal from 'sweetalert2';
    export default {
        name: "game-buttons",
        props: ['id','user_id'],
        data() {
            return {
                actionBar:{
                    showQuestionBtn:true,
                    goToList:true,
                    goToGameList:true,
                    newGame:false
                },
                current_user_id:arrVueConfig['user_id']
            }
        },
        methods:{
            deleteGame(){
                let deleteStatus=false;
                var self = this;
                Swal({
                    title: 'Do you really want to delete this game?',
                    text: "Game and all related data will be deleted permanently",
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
                            'Game won\'t be deleted :)',
                            'info'
                        )
                        deleteStatus=false;
                    }else if(result.value){
                        Swal(
                            'Deleted!',
                            'Game has been deleted.',
                            'success'
                        );

                        //-- Set delete Status to true
                        deleteStatus=true;

                        //-- Functionality to delete specific game with related data
                        axios.post(route('delete_game'), {
                            id: self.id,
                        }).then(response => {
                            if(response['data']['result']=== "success"){
                                self.$toaster.error('Game was successfully deleted');
                            }
                        }).catch(error => {
                            console.log(error);
                        });
                    }

                    //-- Return promise value for next validation
                    return  deleteStatus;

                }).then(function (result) {
                    if(result){
                        bus.$emit('deleteGame',self.id);
                    }
                });
            },
            editGame(){
                this.actionBar.id=this.id;
                bus.$emit('addNewGame', this.actionBar);
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