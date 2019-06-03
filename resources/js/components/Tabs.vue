<template>
    <div>
        <div class="tabs">

                <p v-for="tab in tabs" class="w3-margin-right"  :class="{ 'is-active': tab.isActive }">
                    <a :href="tab.href" @click="selectTab(tab)">{{ tab.name }}</a>
                </p>

        </div>

        <div class="tabs-details">
            <slot></slot>
        </div>
    </div>
</template>

<script>
    import {bus} from '../app';
    export default {
        name: "tabs",
        data() {
            return {
                tabs: []
            };
        },

        created() {

            this.tabs = this.$children;

        },
        methods: {
            selectTab(selectedTab) {

                //-- Reset searching bar value
                bus.$emit('resetSearch', true);

                this.tabs.forEach(tab => {
                    tab.isActive = (tab.name == selectedTab.name);
                });
            }
        }
    }
</script>

<style scoped>
        .tabs p{
            display:inline;
            width:30%;
            margin-bottom:15px;
        }
    .is-active a{
        color:green;
        font-weight:bold;
        text-decoration:underline;
        background:#ccc;
        padding:10px 10px 0 10px;
        border-radius: 15px 15px 0 0;
    }
</style>