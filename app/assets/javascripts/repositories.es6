class Repository {
  constructor(attributes = {}) {
    Object.assign(this, {...attributes, errors: {}});
  }

  static where(path, params) {
    return axios({
      url: `${path}.json`,
      method: 'GET',
      params: params
    });
  }

  static find(path) {
    return axios({
      url: `${path}.json`,
      method: 'GET'
    });
  }

  create(path) {
    return axios({
      url: `${path}.json`,
      method: 'POST',
      data: {}
    });
  }
}

class RepositoriesFilter extends ApplicationFilter {
  get modelClass() {
    return Repository;
  }

  get resultsKey() {
    return 'repositories';
  }
}

class RepositoriesController {
  constructor() {
    this.controller = this;
    this.filter = new RepositoriesFilter({sort: 'id', order: 'desc'});
    this.repository = new Repository();
  }

  index(path){
    this.filter.search(path);
  }

  show(path){
    Repository.find(
      path.replace(':id', new Url().paths().find(p => /\d/.test(p)))
    ).then(success => {
      this.repository = new Repository(success.data.repository);
    });
  }

  create(path) {
    this.repository.create(path).then((success) => {
      alert(JSON.stringify(success.data));
      this.index(path);
    }, (fail) => {
      this.repository.errors = fail.data.errors;
    });
  }

  clear(path) {
    this.filter.clear();
    this.index(path);
  }
}

Vue.controller(RepositoriesController);
