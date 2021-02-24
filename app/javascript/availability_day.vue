<template>
  <div>
    {{ availability_day.availability_date }} {{ availability_day.available }}
  </div>
</template>

<script>


export default {
  props: ['availability_day'],
  name: "availability_day"
}
</script>

<style scoped>

</style>