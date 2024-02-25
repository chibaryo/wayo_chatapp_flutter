importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: 'AIzaSyDYuQ0JZccMGBM6xVorEEzxOjUoPF93LRo',
  appId: '1:1074657064584:web:5d2ffec5a27a0dda41913d',
  messagingSenderId: '1074657064584',
  projectId: 'wayo-chat',
  authDomain: 'wayo-chat.firebaseapp.com',
//  databaseURL:
//      'https://flutter-person-proj-default-rtdb.asia-southeast1.firebasedatabase.app',
  storageBucket: 'wayo-chat.appspot.com',
  measurementId: 'G-PQRKGD2MHK',
});
// Necessary to receive background messages:
//const messaging = firebase.messaging();

// Optional:
/*messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
});*/

self.addEventListener('push', (event) => {
  if (self.Notification == null || self.Notification.permission !== 'granted') {
    return;
  }

  let data = {}
  if (event.data) {
    data = event.data.json();
  }

  console.log("data.data: ", data.data);

  event.waitUntil(
    (() => {
      return self.registration.showNotification(data.notification.title, {
        body: data.notification.body,
        image: data.notification.image,
        actions: [
          {
            action: "action name 1",
            title: "いいね",
          },
          {
            action: "action name 2",
            title: "結構です",
          }
        ]
      });
    })()
  )
});