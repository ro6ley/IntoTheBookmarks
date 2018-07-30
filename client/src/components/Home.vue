<template>
  <div>
    <navbar />
    <h1>{{ msg }}</h1>
    Carousel goes here 👇🏽
    <div class="carousel">
      <a class="carousel-item" href="#one!"><img src="https://lorempixel.com/250/250/nature/1"></a>
      <a class="carousel-item" href="#two!"><img src="https://lorempixel.com/250/250/nature/2"></a>
      <a class="carousel-item" href="#three!"><img src="https://lorempixel.com/250/250/nature/3"></a>
      <a class="carousel-item" href="#four!"><img src="https://lorempixel.com/250/250/nature/4"></a>
      <a class="carousel-item" href="#five!"><img src="https://lorempixel.com/250/250/nature/5"></a>
    </div>
  </div>
</template>

<script>
import Navbar from '@/components/Navbar'

export default {
  name: 'Home',
  components: {
    'navbar': Navbar
  },
  data() {
    return {
      msg: 'This is the landing page component.'
    }
  }
}
</script>

<!-- "scoped" attribute used to limite CSS to this component only -->
<style scoped>
  h1, h2 {
    font-weight: normal;
  }
  ul {
    list-style-type: none;
    padding: 0;
  }
  li {
    display: inline-block;
    margin: 0 10px;
  }
  a {
    color: #42b983;
  }
</style>
