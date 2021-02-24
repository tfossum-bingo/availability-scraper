<template>
  <div>
<!--    <p>{{ listing.id}} {{ listing.airbnb_id }} {{ listing.last_scraped }}</p>-->
    <a v-bind:href="'/hosts/' + listing.host_id + '/listings/' + listing.id">{{ listing.airbnb_id }}</a>
    {{ listing.airbnb_id }} {{ listing.last_scraped }}

  </div>
</template>

<script>
export default {
  props: ["listing"],
  name: "listing"
}
</script>

<style scoped>

</style>