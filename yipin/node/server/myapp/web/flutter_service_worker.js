'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "0361caefb0c12f8980caee13db961823",
"assets/assets/common/ic_analysis.png": "17d55e1ee91335f982bdebe494f0ef94",
"assets/assets/common/ic_analysis_selector.png": "b3732a5002b62795315f7b721eaf0ab3",
"assets/assets/common/ic_back.png": "1991e75e764186e4f65c5d9a56a6e67e",
"assets/assets/common/ic_close.png": "205641974f24f2092436e7ea80e9dec5",
"assets/assets/common/ic_close_white.png": "9a8f873a2b5d9e7b682eef681eedfa99",
"assets/assets/common/ic_contract.png": "1a6d58441d9646c77aa8c61f104f37f0",
"assets/assets/common/ic_contract_selector.png": "8a8b9d510c84a3849bcc07141a9b61b9",
"assets/assets/common/ic_customer.png": "c3722647cf6441412db56dd9bd90decb",
"assets/assets/common/ic_customer_selector.png": "543245b05f2d213d1ca55fcc8627fe5d",
"assets/assets/common/ic_home.png": "7b1d42f10f354382305bddd0ca431aee",
"assets/assets/common/ic_home_selector.png": "35b20fed3f5a3b86904d873743a4f254",
"assets/assets/common/ic_marketing.png": "cf2678c5c31a69209384dd6ec00c163c",
"assets/assets/common/ic_marketing_selector.png": "6469105545320980ce3e4522a93bd9ca",
"assets/assets/common/ic_my.png": "5af203b57749102bfffc91119447babe",
"assets/assets/common/ic_my_selector.png": "2ac9498ead58b6db3139bfba4b7e8711",
"assets/assets/common/ic_net_error.png": "fafa4ff65ab923005a32d1c0253444bf",
"assets/assets/common/ic_nodata.png": "d140e000a3b96ea16c7595e1accaaede",
"assets/assets/common/ic_running.png": "68166efe10600e7936f3475f9810f40a",
"assets/assets/common/ic_running_selector.png": "ca6cb9695e4604cad0311c8659a4a6f8",
"assets/assets/common/ic_users.png": "376f9c5a7a320171906846f797c88f1d",
"assets/assets/common/ic_users_selector.png": "8803ffc1f0e43d9d3e377035979a4d0e",
"assets/assets/common/ic_wx.png": "0b4811603b635d25c782388583508402",
"assets/assets/images/ic_close.png": "205641974f24f2092436e7ea80e9dec5",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "1288c9e28052e028aba623321f7826ac",
"assets/NOTICES": "4915a3b10f98ec618707335727216768",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "09d6f93c198367ea1542ab9dc882ec63",
"/": "09d6f93c198367ea1542ab9dc882ec63",
"main.dart.js": "e677cc6d8e55f2b56d1ced02aae383e3",
"manifest.json": "2af9b93c2d0a505adf3e620f81ae8b76",
"version.json": "fb49b41af2ba88ad149eac81b9653aea"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value + '?revision=' + RESOURCES[value], {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
