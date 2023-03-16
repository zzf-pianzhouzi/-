import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/StuInfo.vue'
import Layout from '../layout/Layout.vue'

const routes = [
  {
    path: '/',
    name: 'Layout',
    component: Layout,
    redirect:"/login",
    children:[
      {
        path: '/tch',
        name: 'TchInfo',
        component: ()=>import("@/views/TchInfo"),
      },
      {
        path: '/tch3',
        name: 'TchStu',
        component: ()=>import("@/views/TchStu"),
      },
      {
        path: '/commonStu',
        name: 'GuanAll',
        component: ()=>import("@/views/GuanAll"),
      },
      {
        path: '/commonTch',
        name: 'GuanAllTch',
        component: ()=>import("@/views/GuanAllTch"),
      },
      {
        path: '/tchUp',
        name: 'TchUp',
        component: ()=>import("@/views/TchUp"),
      },
      {
        path: '/tchNews',
        name: 'TchNews',
        component: ()=>import("@/views/TchNews"),
      },
      {
        path: '/stu',
        name: 'StuInfo',
        component: ()=>import("@/views/StuInfo"),
      },
      {
        path: '/news',
        name: 'News',
        component: ()=>import("@/views/News")
      },
      {
        path: '/stuNews',
        name: 'stuNews',
        component: ()=>import("@/views/StuNews")
      },
      {
        path: '/ggStuInfo',
        name: 'guanStuInfo',
        component: ()=>import("@/views/GuanStuInfo")
      },
      {
        path: '/ggTchInfo',
        name: 'guanTchInfo',
        component: ()=>import("@/views/GuanTchInfo")
      },
      {
        path: '/ggAdd',
        name: 'guanAddMan',
        component: ()=>import("@/views/GuanAddMan")
      },
      {
        path: '/stuUpdate',
        name: 'stuUpdate',
        component: ()=>import("@/views/StuUpdate")
      },
      {
        path: '/tchUpdate',
        name: 'tchUpdate',
        component: ()=>import("@/views/TchUpdate")
      },
    ]
  },
  {
    path: '/login',
    name: 'Login',
    component: ()=>import("@/views/Login")
  },
  {
    path: '/register',
    name: 'Register',
    component: ()=>import("@/views/Register")
  },
  {
    path: '/person',
    name: 'Person',
    component: ()=>import("@/views/Person")
  },



]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
