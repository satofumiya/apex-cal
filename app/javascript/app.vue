<template>
  <v-app>
    <div>
      <v-app-bar elevation="4">
        <v-toolbar-title>ApexData</v-toolbar-title>
      </v-app-bar>
    </div>
    <v-main>
      <v-container>
        <h1 class='pt-16'>{{ index }}試合目</h1>
      <v-row justify="center" align-content="center">
        <v-col>
          <v-text-field  v-model.number="damage" placeholder="ダメージ"/>
        </v-col>
        <v-col>
          <v-text-field v-model.number="killassist" placeholder="キルアシスト数"/>
        </v-col>
        <v-col>
          <v-text-field v-model.number="teamkill" placeholder="チームキル数"/>
        </v-col>
        <v-col>
          <v-text-field v-model.number="ranking" placeholder="順位"/>
        </v-col>
      </v-row>
        <v-row justify="end">
            <v-btn  @click="addData()">試合結果を保存する</v-btn> 
        </v-row>
    

    <div class='py-8'>
      <v-row justify="center">
        <p class="pr-16">平均ダメージ　: {{ averageD }}</p>
        <p>平均順位　: {{ averageR }}</p>
      </v-row>
    </div>

    <v-simple-table dense>
      <template v-slot:default>
      <thead>
        <tr>
          <th class="text-left">
            試合番号
          </th>
          <th class="text-left">
            ダメージ数
          </th>
          <th class="text-left">
            キル、アシスト数
          </th>
          <th class="text-left">
            チームキル数
          </th>
          <th class="text-left">
            順位
          </th>
          <th class="text-left">
            削除ボタン
          </th>
        </tr>
      </thead>
      <tbody>
        <tr
          v-for="(apexdata, index) in apexdatas"
          :key="apexdata.id"
        >
          <td>{{ apexdatas.length - index }}試合目</td>
          <td>{{ apexdata.damage }}</td>
          <td>{{ apexdata.killassist }}</td>
          <td>{{ apexdata.teamkill }}</td>
          <td>{{ apexdata.ranking }}</td>
          <td><v-btn @click='deleteData(apexdata.id)'>削除</v-btn></td>
        </tr>
      </tbody>
    </template>
    </v-simple-table>

    </v-container>
    </v-main>    
  </v-app>
</template>

<script>
import axios from 'axios';
export default {
  data: function () {
    return {
      apexdatas: "apexdatas",
      index: "",
      damage: '',
      killassist: '',
      teamkill: '',
      ranking: '',
      sum: '',
      averageD: 0,
      averageR: 0
    }
  },
  mounted () {
    this.setData();
  },
  computed: {
    averageDamage: function(){
      let List = this.apexdatas
      let totalDamageNum = 0;
        for(let i=0;i <  List.length; i++){
          totalDamageNum += List[i].damage
        }
      return this.$set(this.averageD,totalDamageNum == 0 ? this.averageD = 0:this.averageD = totalDamageNum/List.length)
    },
    averageRank: function(){
      let List = this.apexdatas
      let totalRankNum = 0;
      for(let i=0;i <  List.length; i++){
          totalRankNum += List[i].ranking
      }
      return totalRankNum == 0 ? this.averageR = 0: this. averageR = totalRankNum/List.length
    },
    gameIndex: function(){
      return this.index = this.apexdatas.length+1;
    }
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
