<template>
  <input type='text' v-bind:value='inputData' @keyup="$emit('update', $event.target.value);" />
</template>

<script>
export default {
  name: 'TextInput',
  props: ['inputData']

}
</script>
