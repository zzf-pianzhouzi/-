<template>
  <div style="padding: 10px">
    <!--功能区域-->
管理端添加账号
    <!--搜索区域-->
    <div style="margin: 10px 0">
      <el-button size="mini"  @click="handleEdit2()">添加学生</el-button>
      <el-button size="mini"  @click="handleEdit3()">添加老师</el-button>
    </div>

      <el-dialog v-model="dialogVisible2" title="添加" width="30%">
        <el-form :model="form" label-width="120px">
          <el-form-item label="学号">
            <el-input v-model="form.stuId" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="密码">
            <el-input v-model="form.password" style="width: 80%"></el-input>
          </el-form-item>
          <el-form-item label="姓名">
            <el-input v-model="form.name" style="width: 80%"/>
          </el-form-item>
          <el-form-item label="电话">
            <el-input v-model="form.phone" style="width: 80%"/>
          </el-form-item>
          <el-form-item label="班级">
            <el-input v-model="form.classes" style="width: 80%"/>
          </el-form-item>
          <el-form-item label="角色">
            <el-input v-model="form.role" style="width: 80%"/>
          </el-form-item>
        </el-form>
        <template #footer>
      <span class="dialog-footer">
        <el-button @click="dialogVisible2 = false">取消</el-button>
        <el-button type="primary" @click="addMan">确定</el-button>
      </span>
        </template>
      </el-dialog>
    <el-dialog v-model="dialogVisible3" title="添加" width="30%">
      <el-form :model="form" label-width="120px">
        <el-form-item label="工号">
          <el-input v-model="form.stuId" style="width: 80%"></el-input>
        </el-form-item>
        <el-form-item label="密码">
          <el-input v-model="form.password" style="width: 80%"></el-input>
        </el-form-item>
        <el-form-item label="姓名">
          <el-input v-model="form.name" style="width: 80%"/>
        </el-form-item>
        <el-form-item label="电话">
          <el-input v-model="form.phone" style="width: 80%"/>
        </el-form-item>
        <el-form-item label="管理的班级">
          <el-input v-model="form.classes" style="width: 80%"/>
        </el-form-item>
        <el-form-item label="角色">
          <el-input v-model="form.role" style="width: 80%"/>
        </el-form-item>
      </el-form>
      <template #footer>
      <span class="dialog-footer">
        <el-button @click="dialogVisible3 = false">取消</el-button>
        <el-button type="primary" @click="addMan">确定</el-button>
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
      pageSize: 20,
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
    /*  request.get("http://localhost:9090/stu/queryStuAllAcidMsg",{
        params:{
          stuId:this.user.stuId,
        }
      }).then(res=>{
        console.log(res)
        this.tableData=res.data
        this.total=res.data.length
      })*/
    },

    input() {
      this.$forceUpdate();
    },
    addMan(){
      console.log("form",this.form)
      request.post("http://localhost:9090/common/addStu",this.form).then(res=>{
        console.log(res)
        if (res.code === '0') {
          this.$message({
            type: "success",
            message: "新增成功"
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