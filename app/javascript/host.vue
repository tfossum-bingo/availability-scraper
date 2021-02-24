<template>
  <div>
    <a v-bind:href="'/hosts/' + host.id ">{{ host.host_name }}</a>
    {{ host.airbnb_id }} {{ host.last_scraped }}
  </div>
</template>

<script>
export default {
  props: ["host"],
  name: "host"
}
</script>

<style scoped>

</style>