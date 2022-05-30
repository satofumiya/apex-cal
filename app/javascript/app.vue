<template>
  <div id="app">
    <div>
      <input v-model="damage" placeholder="ダメージ">
      <input v-model="killassist" placeholder="キルアシスト数">
      <input v-model="teamkill" placeholder="チームキル数">
      <input v-model="ranking" placeholder="順位">
      <v-btn @click="addData()">試合結果を保存する</v-btn>
    </div>

    <div>
      <p>平均ダメージ　:</p>{{ averageD }}
    </div>

    <ul>
      <li v-for="(apexdata,index) in apexdatas" :key="apexdata.id">
        {{ apexdatas.length-index }}試合目　{{ apexdata.damage }} {{ apexdata.killassist }} {{ apexdata.teamkill }} {{ apexdata.ranking }}
        <v-btn @click='deleteData(apexdata.id)'>削除</v-btn>
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios';
export default {
  data: function () {
    return {
      apexdatas: "apexdatas",
      damage: '',
      killassist: '',
      teamkill: '',
      ranking: '',
      sum: '',
      averageD: 0,
    }
  },
  mounted () {
    this.setData();
  },
  computed: {
    averageDamage: function(){
      let List = this.apexdatas
      let total = 0;
      for(let i=0;i <  List.length; i++){
        total += List[i].damage
      }
      return this.averageD = total/List.length
    },
  },
  methods: {
  setData: function() {
    axios.get('/api/apexdatas')
    .then(response => (
      this.apexdatas = response.data
    ))
  },
  addData: function() {
    axios.post('/api/apexdatas', {
      damage: this.damage,
      killassist: this.killassist,
      teamkill: this.teamkill,
      ranking: this.ranking,
    })
    .then(response => (
      this.setData(),
      this.damage = '',
      this.killassist = '',
      this.teamkill = '',
      this.ranking = ''
    ));
  },

  deleteData: function(id){
    axios.delete('/api/apexdatas/'+id)
    .then(response => (
      this.setData()
    ));
  },
  
  },
}


</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
