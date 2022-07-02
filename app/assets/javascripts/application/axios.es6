//= require axios/dist/axios

axios.defaults.headers.common['Accept'] = 'application/json';
axios.defaults.headers.common['Content-Type'] = 'application/json';
axios.defaults.withCredentials = true;

axios.interceptors.response.use(
  response => response,
  error => {
    if (error.response.status >= 500) {
      error = {
        response: {
          data: {
            errors: {
              base: error.message
            }
          }
        }
      };
    }

    return Promise.reject(error);
  }
);
