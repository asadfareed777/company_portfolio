'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "320dc2dc8d32734d8bc8bc72565d9341",
"assets/AssetManifest.bin.json": "4cea90245fa44990b58c3b2b8e206fad",
"assets/AssetManifest.json": "beda36b5edcc149d180b5220eff0c4f1",
"assets/assets/images/about_image.jpg": "1752f1429bed26d78f35e4c26e4266e2",
"assets/assets/images/about_image1.jpg": "620d164095684a93092c6b9e1c0b6299",
"assets/assets/images/android_icon.png": "b495669fd9df11bfa81a64f6971f2fb0",
"assets/assets/images/apple_icon.png": "bd3192396a5c514c83027f4abe852907",
"assets/assets/images/artificial_intelligence.png": "6106d44c4eae605c36318c02ee66c054",
"assets/assets/images/automotive.png": "5736ff474f875bf37f702a76df72a1a1",
"assets/assets/images/background.jpg": "06019ef738701c0e08dcd88980c4b07f",
"assets/assets/images/bg-home-image.jpg": "9edf8dd98b98267235168c11d2276cc0",
"assets/assets/images/brand_one_image.png": "d97354a22974f9348d61838632bd4095",
"assets/assets/images/brand_three_image.png": "b5cdc851b9fa8b1eb66421fd4facc1d2",
"assets/assets/images/brand_two_image.png": "3c22f8c51b7070917efea551bbc75e53",
"assets/assets/images/client_centric_approach.jpeg": "8d01024668671a91acb396f9c261d4d6",
"assets/assets/images/contact_us.jpg": "849de19aae16151b6a48267ad943b97e",
"assets/assets/images/customized_solutions.jpg": "3959d88af11e94e3969c6ffa01084be1",
"assets/assets/images/customized_solutions.png": "bafe8847f8f7aabdcab49ee64931ecc2",
"assets/assets/images/details_page.png": "2e4eaae31c8d8e39665adb262be77bda",
"assets/assets/images/e-commerce.png": "ec3eb183037afc304254ea4a7e55525e",
"assets/assets/images/education.png": "25182fdf6924706b3e7b6179aae30e0c",
"assets/assets/images/finance.png": "a67515097e6ce844d0d78290688bf021",
"assets/assets/images/flutter_logo.png": "83e0b762778417141075bba73510d371",
"assets/assets/images/health_care.png": "945b8e02f9c07607a59913c113031eed",
"assets/assets/images/logo-dark.png": "89f017e56496eb54ec49de75dc998f6c",
"assets/assets/images/logo-InvertedTechnology-white.jpg": "fc026fc6bf04c527f64e149e9283f6fa",
"assets/assets/images/logo.png": "2dc3b4ec7ccc0d7ad37ffd7491c8a1ca",
"assets/assets/images/logoInvertedTechnology.png": "5f6288fbb769113e9b2ee8386ae72d9e",
"assets/assets/images/logo_symbol_dark.png": "0ec294d6d3d140e34ce12df0b2ce630d",
"assets/assets/images/logo_white.png": "508bbb2849c64094900a975f6dc6ca14",
"assets/assets/images/portfolio_five_image.jpg": "5fb426e41cf43a46424e7f7695fe10cd",
"assets/assets/images/portfolio_four_image.jpg": "881aa581dd0bfe23278b1553353328fc",
"assets/assets/images/portfolio_one.png": "6ea22756ec2563fe108f881fcacbc095",
"assets/assets/images/portfolio_one_image.jpg": "f7d7fd4da8d9f104b6898b1c7af32146",
"assets/assets/images/portfolio_three.png": "7d49e458c5d7a3d6b0e4b9e21a6b299f",
"assets/assets/images/portfolio_three_image.jpg": "cbfdc8ab9fadf4d9d83b72f18ff165bb",
"assets/assets/images/portfolio_two.jpg": "7517ae43d9ab8792f40f9a440338c090",
"assets/assets/images/portfolio_two_image.jpg": "c39171e2dacaaeb9e579c1537c00a149",
"assets/assets/images/project_image.jpg": "3ff1f98c0c45f5a077a80d942845b235",
"assets/assets/images/proven_track_record.jpg": "51bd685a2c3f9936bf0558b9e068a09c",
"assets/assets/images/proven_track_record.png": "9488a99b4a092cece2bae65503bbfbd7",
"assets/assets/images/quran_app.png": "69998ed9880dedea2fc8aea71a01ab42",
"assets/assets/images/real_estate.png": "42fd5be72186baa1eafa15cfb67b3358",
"assets/assets/images/secure_solutions.jpeg": "6f231ee1a1da22671b79372d876a1435",
"assets/assets/images/web_development.png": "f7163605f9f036fb72cec61e672e857c",
"assets/assets/svgs/details_page.svg": "266c58c25f17a596510382a4505286b1",
"assets/assets/svgs/ic_business_stratagy.svg": "311215c1e7e8bd3779aa8e63207cdba2",
"assets/assets/svgs/ic_heart.svg": "48ac74bfba32dbee2f634c80cbacb6bf",
"assets/assets/svgs/ic_marketing_reporting.svg": "a4d731d94f86b9fcf4e98ba39c3f5eda",
"assets/assets/svgs/ic_mobile_app_development.svg": "e48a250dae0008629c8d059495c67fe1",
"assets/assets/svgs/ic_website_development.svg": "7f0b67faf9a2c2de2f253590f56696f2",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/fonts/MaterialIcons-Regular.otf": "d373fe7085a16fdb1a11b7cf82c13a3f",
"assets/NOTICES": "896b882e380ab94af16ffb959ebbdc4a",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "56e2c9cedd97f10e7e5f1cebd85d53e3",
"assets/packages/flutter_image_compress_web/assets/pica.min.js": "6208ed6419908c4b04382adc8a3053a2",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "27cc3116b8e6906a458a56681dc2638f",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "f3307f62ddff94d2cd8b103daf8d1b0f",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "04f83c01dded195a11d21c2edf643455",
"assets/packages/getwidget/icons/dribble.png": "1e36936e4411f32b0e28fd8335495647",
"assets/packages/getwidget/icons/facebook.png": "293dc099a89c74ae34a028b1ecd2c1f0",
"assets/packages/getwidget/icons/google.png": "596c5544c21e9d6cb02b0768f60f589a",
"assets/packages/getwidget/icons/line.png": "da8d1b531d8189396d68dfcd8cb37a79",
"assets/packages/getwidget/icons/linkedin.png": "822742104a63a720313f6a14d3134f61",
"assets/packages/getwidget/icons/pinterest.png": "d52ccb1e2a8277e4c37b27b234c9f931",
"assets/packages/getwidget/icons/slack.png": "19155b848beeb39c1ffcf743608e2fde",
"assets/packages/getwidget/icons/twitter.png": "caee56343a870ebd76a090642d838139",
"assets/packages/getwidget/icons/wechat.png": "ba10e8b2421bde565e50dfabc202feb7",
"assets/packages/getwidget/icons/whatsapp.png": "30632e569686a4b84cc68169fb9ce2e1",
"assets/packages/getwidget/icons/youtube.png": "1bfda73ab724ad40eb8601f1e7dbc1b9",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "435b451423e159381eb6a9e3433d6e79",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"flutter_bootstrap.js": "6b00ae1a6cd6c04dc1f83bc86acb2a5f",
"icons/Icon-192.png": "17abc83ec4a5b69fc1a3bba02dc75468",
"icons/Icon-512.png": "a9e9e74d8451ee6e9291b0a2ba1f904c",
"icons/Icon-maskable-192.png": "17abc83ec4a5b69fc1a3bba02dc75468",
"icons/Icon-maskable-512.png": "a9e9e74d8451ee6e9291b0a2ba1f904c",
"index.html": "57436c0908c080865dbab2a4a4214413",
"/": "57436c0908c080865dbab2a4a4214413",
"main.dart.js": "3f40aa670181fe16c6c49324525d17f7",
"manifest.json": "b13153538eb045ad06096514372c8a0c",
"version.json": "0c888783def902667cae90eae9e7eea6"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
