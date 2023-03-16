<template>
  <div style="padding: 10px">
    <!--功能区域-->
    <div style="margin: 10px 0">
      教师检查学生页面
      <el-button size="mini"  @click="handleEdit2()">新增</el-button>
    </div>
    <!--搜索区域-->
    <div style="margin: 10px 0">
      <el-input v-model="search" placeholder="输入关键字" style="width:20%" clearable/>
      <el-button type="primary" style="margin-left: 5px" @click="query">查询</el-button>
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
          prop="check"
          label="核验"
          sortable
          width="0"/>
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
    load(){
      request.get("http://localhost:9090/tch/allStuMsg",{
        params:{
          classes:this.user.classes,
        }
      }).then(res=>{
        console.log(res)
        this.tableData=res.data
        this.total=res.data.length
      })
    },
    query(){
      request.get("http://localhost:9090/tch/query",{
        params:{
          name:this.search,
        }
      }).then(res=>{
        console.log(res)
        this.tableData=res.data
        this.total=res.data.length
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
