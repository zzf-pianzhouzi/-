<template>
  <div style="height: 50px; line-height: 50px; border-bottom: 1px solid #ccc; display: flex">
    <div style="width: 200px; padding-left: 30px; font-weight: bold; color: dodgerblue">校园核酸管理系统</div>
    <div style="flex: 1"></div>
    <div style="width: 100px">
      <el-dropdown>
      <span class="el-dropdown-link">
            <el-avatar :size="30"  style="position: relative; top: 10px"></el-avatar>
       {{ this.user.name  }}
        <el-icon class="el-icon--right">
          <arrow-down/>
        </el-icon>
      </span>
      <template #dropdown>
        <el-dropdown-menu>
          <el-dropdown-item @click="$router.push('/login')">退出系统</el-dropdown-item>
        </el-dropdown-menu>
      </template>
    </el-dropdown>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  name: "Header",
  props: ['user'],
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
