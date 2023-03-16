<template>
  <div style="width: 100%;height: 100vh;background-color: darkslateblue;overflow:hidden">
    <div style="width: 400px; margin: 150px auto">
      <div style="font-size: 30px; text-align: center; padding: 30px 0; color: #333">欢迎登录</div>
      <el-form ref="form" :model="form"  size="normal" :rules="rules">
        <el-form-item prop="username">

          <el-input  v-model="form.stuId">
            <template #prefix>
              <el-icon><User/></el-icon>
            </template>
          </el-input>

        </el-form-item>
        <el-form-item prop="password">
          <el-input v-model="form.password"
                    type="password">
            <template #prefix>
              <el-icon><Lock/></el-icon>
            </template>
          </el-input>
        </el-form-item>
        <el-form-item >
          <el-button style="width:100%" type="primary" @click="login">登录</el-button>
        </el-form-item>
      </el-form>
    </div>

  </div>
</template>

<script>
import {User} from '@element-plus/icons';
import {Lock} from '@element-plus/icons';
import request from "@/utils/request";
export default {
  name: "Login.vue",
  components:{
    User,Lock
  },
  data(){
    return{
      form:{},
      rules: {
        stuId: [
          {required: true, message: '请输入用户名', trigger: 'blur'},
        ],
        password: [
          {required: true, message: '请输入密码', trigger: 'blur'},
        ],
      },
    }
  },
  methods:{
    login(){
      this.$refs['form'].validate((valid) => {
        if (valid) {
          request.post("http://localhost:9090/common/login",this.form).then(res=>{
            if (res.code === '0') {
              this.$message({
                type: "success",
                message: "登录成功"
              })
              sessionStorage.setItem("user",JSON.stringify(res.data))  //缓存用户信息
              console.log("res.data：",res.data)
              if (res.data.role===1) this.$router.push("/stuNews")   //登录成功之后跳转到主页
              if (res.data.role===2) this.$router.push("/tchNews")   //登录成功之后跳转到主页
              if (res.data.role===3) this.$router.push("/news")   //登录成功之后跳转到主页

            } else {
              this.$message({
                type: "error",
                message: res.msg
              })
            }
          })
        }
      })

    }
  }
}
</script>


<style scoped>

</style>