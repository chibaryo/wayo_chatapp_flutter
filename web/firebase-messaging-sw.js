self.addEventListener('notificationclick', event => {
  event.notification.close();
  console.log("event", event)
  if (event.notification) {
    console.log("event", event)
    noti = event.notification;
    console.log("notification on notificationclick", noti)
  }

  self.clients.openWindow(event.notification.data.url);
});

importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: 'AIzaSyBSxg71d7IVb_U4QYIKCE-kccCVMUZEFow',
  appId: '1:1023542976787:web:0985ab855d2986ae02fae6',
  messagingSenderId: '1023542976787',
  projectId: 'react-noti-app-5c9f4',
  authDomain: 'react-noti-app-5c9f4.firebaseapp.com',
//  databaseURL:
//      'https://flutter-person-proj-default-rtdb.asia-southeast1.firebasedatabase.app',
  storageBucket: 'react-noti-app-5c9f4.appspot.com',
  measurementId: 'G-P6ZG0Q4ZJS',
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
  console.log("data: ", data);
  console.log("data.notification: ", data.notification);

  event.waitUntil(
    (() => {
      return self.registration.showNotification(data.data.title, {
        body: data.data.body,
        image: data.data.image,
        data: {
          url: data.data.url,
        },
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