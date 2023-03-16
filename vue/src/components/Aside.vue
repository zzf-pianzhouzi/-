<template>
  <div>
    <el-menu
        default-active="user"
        router
        class="el-menu-vertical-demo"
        :default-openeds="['1']"
        style="width: 200px">
      <!--学生端-->
      <el-sub-menu index="1"  v-if="user.role===1">
        <template #title>公告</template>
          <el-menu-item index="stuNews">今日公告</el-menu-item>

      </el-sub-menu >
      <el-sub-menu index="0" v-if="user.role===1">
        <template #title>信息</template>
        <el-menu-item index="stu">核酸信息</el-menu-item>
      </el-sub-menu>
      <el-sub-menu index="2" v-if="user.role===1">
        <template #title>个人中心</template>
        <el-menu-item index="stuUpdate">个人信息</el-menu-item>
      </el-sub-menu>
      <!--教师端-->
      <el-sub-menu index="1" v-if="user.role===2">
        <template #title>公告</template>
        <el-menu-item index="tchNews">今日公告</el-menu-item>

      </el-sub-menu >
      <el-sub-menu index="0" v-if="user.role===2">
        <template #title>信息</template>
        <el-menu-item index="tchUp">上传核酸</el-menu-item>
      </el-sub-menu>
      <el-sub-menu index="2" v-if="user.role===2">
        <template #title>学生核酸</template>
        <el-menu-item index="tch3">对应学生名单</el-menu-item>
        <el-menu-item index="tch">查验学生核酸</el-menu-item>
      </el-sub-menu>
      <el-sub-menu index="3" v-if="user.role===2">
        <template #title>个人中心</template>
        <el-menu-item index="tchUpdate">个人信息</el-menu-item>
      </el-sub-menu>

      <!--管理端-->
      <el-sub-menu index="1" v-if="user.role===3">
        <template #title>公告</template>
        <el-menu-item index="news">今日公告</el-menu-item>

      </el-sub-menu >
      <el-sub-menu index="0" v-if="user.role===3">
        <template #title>信息</template>
        <el-menu-item index="commonStu">学生核酸信息</el-menu-item>
        <el-menu-item index="commonTch">老师核酸信息</el-menu-item>

      </el-sub-menu>
      <el-sub-menu index="2" v-if="user.role===3">
        <template #title>管理中心</template>
        <el-menu-item index="ggAdd">添加账号</el-menu-item>
        <el-menu-item index="ggStuInfo">学生管理</el-menu-item>
        <el-menu-item index="ggTchInfo">教师管理</el-menu-item>
      </el-sub-menu>

<!--      <el-menu-item index="book">书籍管理</el-menu-item>
      <el-menu-item index="news" v-if="user.role===2">新闻管理</el-menu-item>-->

    </el-menu>


  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "Aside",
  data() {
    return {
      user: {}
    }
  },
  created() {
    let userStr = sessionStorage.getItem("user")
    this.user = JSON.parse(userStr)
    console.log("user",userStr)
    console.log("this.user",this.user)
    console.log("user.role",this.user.role)
      //请求服务端，确认当前登录的用户的合法信息
    request.get("http://localhost:9090/common/"+this.user.id).then(res=>{
      if (res.code==='0'){
        this.user=res.data
      }
    })
  }
}

</script>

<style scoped>

</style>