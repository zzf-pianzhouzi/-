<template>
  <div style="padding: 10px">
    <!--功能区域-->
学生端修改页面
    <!--搜索区域-->
    <div style="margin: 10px 0">
      <el-button size="mini"  @click="handleEdit2()">修改电话</el-button>
      <el-button size="mini"  @click="handleEdit3()">修改密码</el-button>
    </div>
    <el-table :data="tableData" border stripe style="width: 100%">
      <el-table-column
          prop="stuId"
          label="工号"
          width="0" />
      <el-table-column
          prop="name"
          label="姓名"
          width="0"/>
      <el-table-column
          prop="classes"
          label="管理班级"
          width="0"/>
      <el-table-column
          prop="phone"
          label="电话"
          width="0"/>
    </el-table>

      <el-dialog v-model="dialogVisible2" title="修改电话" width="30%">
        <el-form :model="form" label-width="120px">
          <el-form-item label="new电话">
            <el-input v-model="form.phone" style="width: 80%"></el-input>
          </el-form-item>
        </el-form>
        <template #footer>
      <span class="dialog-footer">
        <el-button @click="dialogVisible2 = false">取消</el-button>
        <el-button type="primary" @click="updatePhone">确定</el-button>
      </span>
        </template>
      </el-dialog>
    <el-dialog v-model="dialogVisible3" title="修改密码" width="30%">
      <el-form :model="form" label-width="120px">
        <el-form-item label="新密码">
          <el-input v-model="form.pwd" style="width: 80%"></el-input>
        </el-form-item>
      </el-form>
      <template #footer>
      <span class="dialog-footer">
        <el-button @click="dialogVisible3 = false">取消</el-button>
        <el-button type="primary" @click="updatePassword">确定</el-button>
      </span>
      </template>
    </el-dialog>
    </div>

</template>

<script>


import request from "@/utils/request";
import moment from 'moment'

//时间数据的存放



export default {

  name: 'HomeView',
  components: {

  },
  data(){
    return {
      user:{},
      form:{},
      dialogVisible:false,
      dialogVisible2:false,
      dialogVisible3:false,
      search:'',
      currentPage: 1,
      pageSize: 5,
      total:0,
      params: {
        date: '',
      },
     /* params: {
        startTime: '',
        endTime: '',
        date: '',
      },*/
      tableData:[
      ],
    }
  },

  //页面加载时调用
  created() {
    let userStr = sessionStorage.getItem("user") || "{}"
    this.user = JSON.parse(userStr)
    this.load()
  },
  methods: {



    filesUploadSuccess(res) {
      console.log(res)
      this.form.pic = res.data
    },
    changeDate(val) {
      this.$forceUpdate()
      this.value= val;
    },
    load(){
      console.log("stuId",this.user.stuId)
      request.get("http://localhost:9090/stu/queryStuMsg",{
        params:{
          stuId:this.user.stuId,
        }
      }).then(res=>{
        console.log("loadres",res)
        this.tableData=res.data
        this.total=res.data.length
      })
    },

    input() {
      this.$forceUpdate();
    },
    updatePhone(){
      console.log("form",this.form.phone)
      request.get("http://localhost:9090/stu/changePho",{
        params:{
          stuId:this.user.stuId,
          phone:this.form.phone,
        }
      }).then(res=>{
        console.log(res)
        if (res.code === '0') {
          this.$message({
            type: "success",
            message: "修改成功"
          })
        } else {
          this.$message({
            type: "error",
            message: res.msg
          })
        }
        this.load()  //刷新表格的数据
        this.dialogVisible2 = false //关闭弹窗
      })
    },
    updatePassword(){
      console.log("form",this.form.pwd)
      request.get("http://localhost:9090/stu/changePwd",{
        params:{
          stuId:this.user.stuId,
          pwd:this.form.pwd,
        }
      }).then(res=>{
        console.log(res)
        if (res.code === '0') {
          this.$message({
            type: "success",
            message: "修改成功"
          })
        } else {
          this.$message({
            type: "error",
            message: res.msg
          })
        }
        this.load()  //刷新表格的数据
        this.dialogVisible3 = false //关闭弹窗
      })
    },
    handleEdit(row){
      this.form=JSON.parse(JSON.stringify(row))
      this.dialogVisible=true
    },
    handleEdit2(){
      this.dialogVisible2=true
      this.form = {}
      this.$refs['upload'].clearFiles()   //清除历史文件列表
    },
    handleEdit3(){
      this.dialogVisible3=true
      this.form = {}
      this.$refs['upload'].clearFiles()   //清除历史文件列表
    },
    handleSizeChange(){       //改变当前每页的个数
      this.load()
    },
    handleCurrentChange(){    //改变当前页面
      this.load()
    },

  }
}




</script>