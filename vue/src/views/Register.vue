<template>
  <div style="width: 100%;height: 100vh;background-color: darkslateblue;overflow:hidden">
    <div style="width: 400px; margin: 150px auto">
      <div style="font-size: 30px; text-align: center; padding: 30px 0; color: #333">欢迎注册</div>
      <el-form ref="form" :model="form"  size="normal" :rules="rules">
        <el-form-item prop="username">

          <el-input  v-model="form.username">
            <template #prefix>
              <el-icon><User/></el-icon>
            </template>
          </el-input>

        </el-form-item>
        <el-form-item prop="password">
          <el-input v-model="form.password" >
            <template #prefix>
              <el-icon><Lock/></el-icon>
            </template>
          </el-input>
        </el-form-item>

        <el-form-item prop="confirm">
          <el-input v-model="form.confirm" >
            <template #prefix>
              <el-icon><Lock/></el-icon>
            </template>
          </el-input>
        </el-form-item>

        <el-form-item>
          <el-button style="width: 100%" type="primary" @click="register">注册</el-button>
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
  name: "Register.vue",
  components:{
    User,Lock
  },
  data(){
    return{
      form:{},
      rules: {
        username: [
          {required: true, message: '请输入用户名', trigger: 'blur'},
        ],
        password: [
          {required: true, message: '请输入密码', trigger: 'blur'},
        ],
        confirm: [
          {required: true, message: '请确认密码', trigger: 'blur'},
        ],
      },
    }
  },
  methods:{
    register(){
      if (this.form.password!==this.form.confirm){
        this.$message({
          type:"error",
          message:'两次密码输入不一致！'
        })
        return
      }

      this.$refs['form'].validate((valid) => {
        if (valid) {
          request.post("http://localhost:9090/user/register",this.form).then(res=>{
            if (res.code === '0') {
              this.$message({
                type: "success",
                message: "注册成功"
              })
              this.$router.push("/login")   //注册成功之后跳转到登录页面
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