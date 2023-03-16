<template>
  <div style="padding: 10px">
    <!--    功能区域-->


    <!--    搜索区域-->
    <div style="margin: 10px 0">
      <el-date-picker
          v-model="params.date"
          type="date"
          value-format="YYYY-MM-DD"
          placeholder="日期"
          @change="dateFormat">
      </el-date-picker>
      <el-button type="primary" style="margin-left: 5px" @click="query">查询</el-button>
    </div>
    <el-table
        v-loading="loading"
        :data="tableData"
        border
        stripe
        style="width: 100%">
      <el-table-column
          prop="id"
          label="ID"
          sortable
      >
      </el-table-column>
      <el-table-column
          prop="title"
          label="标题">
      </el-table-column>
      <el-table-column
          prop="author"
          label="作者">
      </el-table-column>
      <el-table-column
          prop="Newstime"
          :formatter="formatDate"
          label="时间">
      </el-table-column>
      <el-table-column label="操作">
        <template #default="scope">
          <el-button size="mini" @click="details(scope.row)">详情</el-button>
        </template>
      </el-table-column>
    </el-table>

    <div style="margin: 10px 0">
      <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="currentPage"
          :page-sizes="[5, 10, 20]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total">
      </el-pagination>
    </div>

    <el-dialog title="提示" v-model="dialogVisible" width="50%">
      <el-form :model="form" label-width="120px">
        <el-form-item label="标题">
          <el-input v-model="form.title" style="width: 50%"></el-input>
        </el-form-item>

        <div id="div1"></div>
      </el-form>
      <template #footer>
          <span class="dialog-footer">
            <el-button @click="dialogVisible = false">取 消</el-button>
            <el-button type="primary" @click="save">确 定</el-button>
          </span>
      </template>
    </el-dialog>

    <el-dialog title="详情" v-model="vis" width="50%">
      <el-card>
        <div v-html="detail.content" style="min-height: 100px"></div>
      </el-card>
    </el-dialog>

  </div>
</template>

<script>

import E from 'wangeditor'
import request from "@/utils/request";

let editor;

export default {
  name: 'stuNews',
  components: {},
  data() {
    return {
      user:{},
      loading: true,
      form: {},
      dialogVisible: false,
      search: '',
      currentPage: 1,
      pageSize: 10,
      params: {
        date: '',
      },
      total: 0,
      tableData: [],
      vis: false,
      detail: {},
    }
  },
  created() {
    let userStr = sessionStorage.getItem("user") || "{}"
    this.user = JSON.parse(userStr)
    this.load()
  },
  methods: {
    details(row) {
      this.detail = row
      this.vis = true
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
    query(){
      console.log("date",this.params.date)
      request.get("http://localhost:9090/news/queryDate",{
        params:{
          date:this.params.date,
        }
      }).then(res=>{
        console.log(res)
        console.log("res.data.length",res.data.length)
        this.tableData=res.data
        this.total=res.data.length
      })
    },
    filesUploadSuccess(res) {
      console.log(res)
      this.form.cover = res.data
    },
    load() {
      this.loading = true
      request.get("http://localhost:9090/news/getAllNews").then(res => {
        this.loading = false
        this.tableData = res.data
        this.total = res.data.length
      })
    },

    handleSizeChange(pageSize) {   // 改变当前每页的个数触发
      this.pageSize = pageSize
      this.load()
    },
    handleCurrentChange(pageNum) {  // 改变当前页码触发
      this.currentPage = pageNum
      this.load()
    }
  }
}
</script>
