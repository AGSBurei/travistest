<template>
  <div class="avatar" v-bind:style="{ background: randomColorByUsername() }">
    {{ printFirstChar() }}
  </div>
</template>

<script>
export default {
  name: 'Avatar',
  props: ['username'],
  methods: {
    printFirstChar() {
      return this.username.charAt(0);
    },
    randomColorByUsername() {
      let hash = 0;
      for (let i = 0; i < this.username.length; i++) {
        hash = this.username.charCodeAt(i) + ((hash << 5) - hash);
      }
      let colour = "#";
      for (let i = 0; i < 3; i++) {
        let value = (hash >> (i * 8)) & 0xff;
        colour += ("00" + value.toString(16)).substr(-2);
      }
      return colour;
    }
  }
};
</script>

<style scoped>
.avatar {
  display: flex;
  position: relative;
  overflow: hidden;
  font-size: 1.25rem;
  flex-shrink: 0;
  align-items: center;
  user-select: none;
  border-radius: 50%;
  justify-content: center;
  width: 36px;
  color: #fff;
  height: 36px;
  font-size: 20px;
  margin-right: -4px;
}
</style>