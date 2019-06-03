<template>
    <div>

        <p>
            <router-link :to="{ name: 'quiz' }">Quiz view</router-link>
        </p>
        <router-view></router-view>
        <div id="timerPopup"></div>
    </div>
</template>

<script>
    export default {
        name: "main-view"
    }
</script>

<style scoped>
    #timerPopup {
        position: fixed;
        top: 20%;
        right: 20%;
        height: 70px;
        width: 70px;
        border-radius: 40px;
        display: none;
        background-color: #00B5AD;
        font-size: 36px;
        text-align: center;
        padding-top: 6px;
        padding-right: 4px;
        color: #f9f7ea;
    }
</style>