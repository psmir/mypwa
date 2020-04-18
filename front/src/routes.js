const routes = [
  { path: '/', component: () => import('./components/Home') },
  { path: '/login', component: () => import('./components/Login') },
  { path: '/signup', component: () => import('./components/SignUp') },
  { path: '/messenger/:current_room?', component: () => import('./components/Messenger'), name: 'messenger', props: true },
];

export default routes;
