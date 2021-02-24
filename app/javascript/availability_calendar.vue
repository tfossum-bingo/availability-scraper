<template>
  <div id="availability_calendar">
    <!-- Using Component -->
    <calendar
        :eventCategories="eventCategories"
        :events="events"
        ref="calendar"
    />
  </div>
</template>

<script>
import {Calendar} from 'vue-sweet-calendar'
import 'vue-sweet-calendar/dist/SweetCalendar.css'

export default {
  props: ['events'],
  name: "availability_calendar",
  data() {
    return {
      eventCategories: [
        {
          id: 1,
          title: 'Available',
          textColor: 'white',
          backgroundColor: 'Blue'
        },
        {
          id: 2,
          title: 'Booked',
          textColor: 'white',
          backgroundColor: 'red'
        }
      ]
    }
  },
  methods: {
    goToday() {
      this.$refs.calendar.goToday()
    }
  },
  components: {
    Calendar // Registering Component
  }
}
</script>

<style scoped>

</style>