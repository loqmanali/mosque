self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open('mosque-cache-v1').then((cache) => {
      return cache.addAll([
        '/',
        '/index.html',
        '/main.dart.js',
        '/flutter_service_worker.js',
        '/manifest.json',
        '/assets/fonts/MaterialIcons-Regular.otf',
        '/icons/Icon-192.png',
        '/icons/Icon-512.png',
        '/icons/Icon-512.png'
      ]);
    })
  );
});

self.addEventListener('fetch', (event) => {
  event.respondWith(
    caches.match(event.request).then((response) => {
      return response || fetch(event.request);
    })
  );
}); 