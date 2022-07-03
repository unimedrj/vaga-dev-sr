# GitJMD

![Modeling](https://raw.githubusercontent.com/juniormesquitadandao/vaga-dev-sr/master/architecture/modeling.png)

## AWS Resoucers

- RDS
  - DB: Postgresql
  - Version: 14.1-R1
  - Instance: db.t3.micro
  - Free Tier? Yes
- ElastiCash
  - DB: Redis
  - Version: 6.2
  - Instance: cash.t4g.micro
  - Free Tier? No
  - Price Per Hour: $0.016

## Setup

- Configure host: https://github.com/juniormesquitadandao/gerlessver

```sh
cd github
  echo 'GITHUB_PERSONAL_ACCESS_TOKEN=YOUR_GITHUB_PERSONAL_ACCESS_TOKEN' > .env.docker-compose
  chmod +x devops/**/*.sh
  ./devops/github/repositories.sh
  ./devops/compose/config.sh
  ./devops/compose/build.sh
  ./devops/compose/up.sh
  ./devops/compose/exec.sh app bash
    ruby -v
    node -v
    bundle install
    npm install

    rubocop -a
    bundle-audit
    circleci config validate


    date > .keep
    git status
    git diff
    git add .
    git commit -m 'update .keep'
    git status
    git push

    rails db:create
    RAILS_ENV=test rails db:create
    rails db:migrate db:seed
    rspec

    rails c
      Redis.new.keys
      exit
    rails s
    # Brower: http://localhost:3000
    # Press: CTRL+C
    exit
  ./devops/compose/down.sh
```
