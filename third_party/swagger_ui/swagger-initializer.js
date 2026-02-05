window.onload = function() {
  //<editor-fold desc="Changeable Configuration Block">

  // the following lines will be replaced by docker/configurator, when it runs in a docker-container
  window.ui = SwaggerUIBundle({
    url: "/api.swagger.json",
    requestInterceptor: (req) => {
      try {
        const url = new URL(req.url, window.location.origin);
        if (url.hostname === "localhost" || url.hostname === "127.0.0.1") {
          if (url.protocol === "https:") {
            url.protocol = "http:";
            req.url = url.toString();
          }
        }
      } catch (e) {
        // ignore URL parsing errors
      }

      req.credentials = "include";
      const csrf = document.cookie
        .split(";")
        .map((entry) => entry.trim())
        .find((entry) => entry.startsWith("csrf_token="));
      if (csrf) {
        const value = csrf.split("=")[1];
        if (value) {
          req.headers = req.headers || {};
          req.headers["X-CSRF-Token"] = value;
        }
      }
      return req;
    },
    dom_id: '#swagger-ui',
    deepLinking: true,
    presets: [
      SwaggerUIBundle.presets.apis,
      SwaggerUIStandalonePreset
    ],
    plugins: [
      SwaggerUIBundle.plugins.DownloadUrl
    ],
    layout: "StandaloneLayout"
  });

  //</editor-fold>
};
