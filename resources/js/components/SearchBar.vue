<template>
    <div>
        <input type="text" class="form-control" placeholder="Search..." @input="searchLine" v-model="search">
    </div>
</template>

<script>
    import {bus} from '../app';
    export default {
        name: "search-bar",
        data(){
            return{
                search:""
            }
        },
        methods:{
            searchLine(){
                this.$emit('search',this.search);
            }
        },
        created(){
            //-- Reset searching bar value
            bus.$on('resetSearch', (data)=>{
                if(data){
                    this.search="";
                }
            });
        }
    }
</script>

<style scoped>

</style>