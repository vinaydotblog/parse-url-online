<template>
  <Hello msg="Welcome to Your Vue.js App"/>
</template>

<script>
import Hello from './components/URLParser.vue'
import './index.css'

export default {
  name: 'App',
  components: {
    Hello
  }
}
</script>

<style>
body {
  background: #f6f6f6;
}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: #2c3e50;
  margin: auto;
  margin-top: 60px;
  width: 80%;
}
</style>
