class ApplicationFilter {
  constructor(attributes = {sort: null, order: null}) {
    Object.assign(this, {
      params: {sort: attributes.sort, order: attributes.order, offset: 0, limit: 10},
      results: [],
      count: 0,
      errors: {}
    });
  }

  search(path){
    return this.modelClass.where(path, this.toParams()).then(success => {
      this.results = success.data[this.resultsKey].map(result => new this.modelClass(result));
      this.count = success.data.count;
      this.errors = {};
    }, ({response}) => {
      console.log(response);
      this.errors = response.data.errors;
    })
  }

  isPrevious() {
    return this.params.offset - this.params.limit >= 0;
  }

  isNext() {
    return this.params.offset + this.params.limit < this.count;
  }

  page() {
    if(this.params.offset <= 0) {
      return 1;
    }

    if (this.params.offset + this.params.limit >= this.count) {
      return this.pages();
    }

    return Math.trunc(this.params.offset / this.params.limit) + 1;
  }

  pages() {
    return Math.ceil(this.count / this.params.limit);
  }

  paginationLabel(format) {
    return format.replace(/\{page\}/g, this.page())
      .replace(/\{pages\}/g, this.pages())
      .replace(/\{count\}/g, this.count);
  }

  first(controller, path) {
    if (this.isPrevious()) {
      this.params.offset = 0;
      controller.index(path);
    }
  }

  previous(controller, path) {
    if (this.isPrevious()) {
      this.params.offset -= this.params.limit;
      controller.index(path);
    }
  }

  next(controller, path) {
    if (this.isNext()){
      this.params.offset += this.params.limit;
      controller.index(path);
    }
  }

  last(controller, path) {
    if (this.isNext()){
      this.params.offset = (this.pages() - 1) * this.params.limit;
      controller.index(path);
    }
  }

  clear() {
    Object.assign(this, {
      params: {sort: this.params.sort, order: this.params.order, offset: this.params.offset, limit: this.params.limit},
      results: this.results,
      count: this.count,
      errors: {}
    });
  }

  toParams() {
    const params = {...this.params};

    Object.keys(params).forEach((paramName) => {
      if (params[paramName] === '') {
        delete params[paramName];
      }
    });

    return params;
  }
}
