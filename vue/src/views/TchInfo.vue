<template>
  <div style="padding: 10px">
    <!--功能区域-->
    <div style="margin: 10px 0">
      教师检查学生页面2

    </div>
    <!--搜索区域-->
    <div style="margin: 10px 0">
      <el-input v-model="search" placeholder="输入学生姓名" style="width:20%" clearable/>
      <el-date-picker
          v-model="params.date"
          type="date"
          value-format="YYYY-MM-DD"
          placeholder="日期"
          @change="dateFormat">
      </el-date-picker>
      <el-button type="primary" style="margin-left: 5px" @click="query">查询</el-button>
      <el-button type="primary" style="margin-left: 5px" @click="query2">日期查询</el-button>
    </div>

    <el-table :data="tableData" border stripe style="width: 100%">
      <el-table-column
          prop="stuId"
          label="学号"
          width="0" />
      <el-table-column
          prop="name"
          label="姓名"
          width="0"/>
      <el-table-column
          prop="classes"
          label="班级"
          width="0"/>
      <el-table-column
          prop="phone"
          label="电话"
          width="0"/>
      <el-table-column
          label="核酸图片">
        <template #default="scope">
          <el-image
              style="width: 100px; height: 100px"
              :src="scope.row.pic"
              :preview-src-list="[scope.row.pic]">
          </el-image>
        </template>
      </el-table-column>

      <el-table-column
          prop="time"
          :formatter="formatDate"
          label="上传时间"
          sortable
          width="0"/>
      <el-table-column
          prop="check"
          label="核验"
          sortable
          width="0"/>
      <el-table-column
          fixed="right"
          label="操作"
          width="200px">


        <template #default="scope">
          <el-button size="mini"  @click="handleCheck(scope.row.checkId)">核验通过</el-button>
          <el-button size="mini"  @click="handleCheck2(scope.row.checkId)">核验不通过</el-button>
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

    </div>
  </div>
</template>

<script>


import request from "@/utils/request";

export default {

  name: 'HomeView',
  components: {

  },
  data(){
    return {
      user:{},
      form:{},
      search:'',
      currentPage: 1,
      pageSize: 2,
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
      // this.params.startTime=picker[0]
      // this.params.endTime=picker[1]
      //类型是type="daterange"
      this.params.date=picker
      // this.params.Time=picker
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
    load(){
      console.log("Time:",this.params.date)
      request.get("http://localhost:9090/tch/allAcidMsg",{
        params:{
          currPage:this.currentPage,
          pageSize:this.pageSize,
          classes:this.user.classes,
        }
      }).then(res=>{
        console.log("result123123123",res)
        this.tableData=res.data
        this.total=res.data.length
      })
    },
    query(){
      request.get("http://localhost:9090/tch/queryStuAcidByNameClasses",{
        params:{
          name:this.search,
          classes:this.user.classes,
        }
      }).then(res=>{
        console.log(res)
        this.tableData=res.data
        this.total=res.data.length
      })
    },
    query2(){
      console.log("date",this.params.date)
      request.get("http://localhost:9090/tch/allAcidMsgDateTotal",{
        params:{
          classes:this.user.classes,
          Time:this.params.date,
        }
      }).then(res=>{
        console.log(res)
        console.log("res.data.length",res.data.length)
        this.tableData=res.data
        this.total=res.data.length
      })
    },
    handleCheck(id){
      console.log("id",id)
      request.put("http://localhost:9090/tch/check/" + id).then(res=>{
        console.log(res)
        if (res.code === '0') {
          this.$message({
            type: "success",
            message: "核验成功"
          })
        } else {
          this.$message({
            type: "error",
            message: res.msg
          })
        }
        this.load()  //刷新表单
      })


    },
    handleCheck2(id){
      console.log("id",id)
      request.put("http://localhost:9090/tch/checked/" + id).then(res=>{
        console.log(res)
        if (res.code === '0') {
          this.$message({
            type: "success",
            message: "核验成功"
          })
        } else {
          this.$message({
            type: "error",
            message: res.msg
          })
        }
        this.load()  //刷新表单
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
