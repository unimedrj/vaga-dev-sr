class Repository {
  constructor(attributes = {}) {
    Object.assign(this, {...attributes, errors: {}});
  }

  static where(path, params) {
    return axios({
      url: path,
      method: 'GET',
      params: params
    });
  }

  static find(path) {
    return axios({
      url: path,
      method: 'GET'
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
    this.filter = new RepositoriesFilter({sort: 'id', order: 'asc'});
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
}

Vue.controller(RepositoriesController);
