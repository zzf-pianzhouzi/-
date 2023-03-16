<template>
  <div style="padding: 10px">
    <!--功能区域-->

    <!--搜索区域-->
    <div style="margin: 10px 0">
      <el-input v-model="search" placeholder="输入班级" style="width:20%" clearable/>
<!--      <el-button type="primary" style="margin-left: 5px" @click="query">查询</el-button>-->
    </div>

    <el-date-picker
        v-model="params.date"
        type="date"
        value-format="YYYY-MM-DD"
        placeholder="日期"
        @change="dateFormat">
    </el-date-picker>
    <el-button type="primary" style="margin-left: 5px" @click="query2">日期+学号查询</el-button>


    <el-table :data="tableData" border stripe style="width: 100%">

      <el-table-column
          prop="stuId"
          label="学号"
          width="0" />
      <el-table-column
          prop="name"
          label="姓名"
          width="0" />
      <el-table-column
          prop="classes"
          label="班级"

          width="0" />
      <el-table-column
          label="图片">
        <template #default="scope">
          <el-image
              style="width: 100px; height: 100px"
              :src="scope.row.pic"
              :preview-src-list="[scope.row.pic]">
          </el-image>
        </template>
      </el-table-column>
      <el-table-column
          prop="check"
          sortable
          label="核验"
          width="0"/>
      <el-table-column
          prop="time"
          :formatter="formatDate"
          sortable
          label="上传时间"
          width="0"/>

      <el-table-column
          fixed="right"
          label="操作"
          width="200px">
        <template #default="scope">
          <el-button size="mini"  @click="handleEdit(scope.row)">编辑</el-button>
          <el-popconfirm title="确定删除吗" @confirm="handleDelete(scope.row.id)">
            <template #reference>
              <el-button size="mini" type="danger">删除</el-button>
            </template>
          </el-popconfirm>
        </template>
      </el-table-column>
    </el-table>
    <div style="margin: 10px 0">
      <el-pagination
          v-model:currentPage="currentPage"
          v-model:page-size="pageSize"
          :page-sizes="[5, 10, 20]"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total"
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
      />

      <el-dialog v-model="dialogVisible" title="编辑" width="30%">
        <el-form :model="form" label-width="120px">
          <el-form-item label="学号">
            <el-input v-model="form.stuId" style="width: 80%"/>
          </el-form-item>

          <el-form-item label="图片">
            <el-upload ref="upload"
                       action="http://localhost:9090/files/upload" :on-success="filesUploadSuccess">
              <el-button type="primary">点击上传</el-button>
            </el-upload>
          </el-form-item>
          <el-form-item label="上传时间">
            <el-input type="textarea" v-model="form.time" style="width: 80%"/>
          </el-form-item>

        </el-form>
        <template #footer>
      <span class="dialog-footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="save">确定</el-button>
      </span>
        </template>
      </el-dialog>

    </div>
  </div>
</template>

<script>


import request from "@/utils/request";
import { ref } from 'vue'



const value = ref('')


const disabledDate = (time,Date) => {
  return time.getTime() > Date.now()
}



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
      search:'',
      currentPage: 1,
      pageSize: 5,
      total:0,
      params: {
        date: '',
      },
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
    dateFormat(picker){
      this.params.date=picker
    },
    formatDate(row, column) {
      // 获取单元格数据
      let data = row[column.property]
      if(data == null) {
        return null
      }
      let dt = new Date(data)
      return dt.getFullYear() + '-' +   ((dt.getMonth() + 1) < 10 ? ('0' + (dt.getMonth() + 1)) : (dt.getMonth() + 1)) + '-' +

          (dt.getDate() < 10 ? ('0' + dt.getDate()) : dt.getDate()) + ' ' +

          (dt.getHours() < 10 ? ('0' + dt.getHours()) : dt.getHours()) + ':' +

          (dt.getMinutes() < 10 ? ('0' + dt.getMinutes()) : dt.getMinutes()) + ':' +

          (dt.getSeconds() < 10 ? ('0' + dt.getSeconds()) : dt.getSeconds())
    },
    changeDate(val) {
      this.$forceUpdate()
      this.value= val;
    },
    load(){
      request.post("http://localhost:9090/common/allStuAcid",{
        params:{
          stuId:this.user.stuId,
        }
      }).then(res=>{
        console.log(res)
        this.tableData=res.data
        this.total=res.data.length
      })
    },

    input() {
      this.$forceUpdate();
    },
    query(){
      request.get("http://localhost:9090/tch/allStuMsg",{
        params:{
          classes:this.search,
        }
      }).then(res=>{
        console.log(res)
        this.tableData=res.data
        this.total=res.data.length
      })
    },
    query2(){
      console.log("this.search",this.search)
      console.log("this.params.date",this.params.date)
      request.get("http://localhost:9090/tch/allAcidMsgDate",{
        params:{
          classes:this.search,
          Time:this.params.date,
        }
      }).then(res=>{
        console.log(res)
        console.log("res.data.length",res.data.length)
        this.tableData=res.data
        //this.total=res.data.length
      })
    },
    save(){
      //上传图片
        request.put("http://localhost:9090/stu",this.form).then(res => {
          console.log(res)
          if (res.code === '0') {
            this.$message({
              type: "success",
              message: "更新成功"
            })
          } else {
            this.$message({
              type: "error",
              message: res.msg
            })
          }
          this.load()  //刷新表格的数据
          this.dialogVisible = false //关闭弹窗
        })
      },
    handleEdit(row){
      //表单深拷贝
      this.form=JSON.parse(JSON.stringify(row))
      this.dialogVisible=true
  /*    this.$nextTick(()=>{
        this.$refs['upload'].clearFiles()   //清除历史文件列表
      })*/

    },
    handleDelete(id){
      console.log(id)
      request.delete("http://localhost:9090/stu/" + id).then(res=>{
        if (res.code === '0') {
          this.$message({
            type: "success",
            message: "删除成功"
          })
        } else {
          this.$message({
            type: "error",
            message: res.msg
          })
        }
        this.load()  //重新加载删除之后表格的数据
      })
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