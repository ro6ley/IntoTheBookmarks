import Vue from 'vue'
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'
import Home from '@/components/Home'
import Bookmarks from '@/components/Bookmarks'
import HomePage from '@/components/HomePage'
import Login from '@/components/Login'
import Register from '@/components/Register'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'HelloWorld',
      component: HelloWorld
    },
    {
      path: '/login',
      name: 'Login',
      component: Login
    },
    {
      path: '/register',
      name: 'Register',
      component: Register
    },
    {
      path: '/index',
      name: 'Home',
      component: Home
    },
    {
      path: '/home',
      name: 'HomePage',
      component: HomePage
    },
    {
      path: '/bookmarks',
      name: 'Bookmarks',
      component: Bookmarks
    }
  ]
})
