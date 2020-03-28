import Home from './components/Home'
import Login from './components/Login'
import SignUp from './components/SignUp'
import Messenger from './components/Messenger'

const routes = [
  { path: '/', component: Home },
  { path: '/login', component: Login },
  { path: '/signup', component: SignUp },
  { path: '/messenger/:current_room?', component: Messenger, name: 'messenger', props: true },
];

export default routes;
