import axios from 'axios'

const baseDomain = process.env.VUE_APP_SERVER_URL;

axios.defaults.withCredentials = true;

export default {
  run(name, payload) {
    return new Promise(function(resolve, reject){
      axios.post(`${baseDomain}/operation`, {
        name: name,
        payload: payload
      }).then(response => {
        if(response.data.success) {
          resolve(response.data.payload)
        } else {
          reject(response.data.errors)
        }
      })
      .catch(function(error) {
        console.log("Request error:")
        console.log(error)
      })
    })
  },
}
