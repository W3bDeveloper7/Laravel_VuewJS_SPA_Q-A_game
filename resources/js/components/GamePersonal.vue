<template>
    <div>
        <view-main :id="id" :title="title" :personal="personal"></view-main>
    </div>
</template>

<script>
    import {bus} from '../app';
    export default {
        name: "game-personal",
        data() {
            return {
                id: this.$route.params.id,
                title: 'Personal game',
                personal: true
            }
        },
        created() {

        }
    }
</script>

<style scoped>

</style>