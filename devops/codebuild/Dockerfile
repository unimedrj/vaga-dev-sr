FROM vaga-dev-sr_app:latest

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
  unzip -q awscliv2.zip && \
  ./aws/install && \
  aws --version

COPY --chown=user:user . vaga-dev-sr

WORKDIR /home/user/vaga-dev-sr

ENV RAILS_ENV=production
ENV NODE_ENV=production

RUN bundle install && \
  npm install

ARG ARG_RAILS_MASTER_KEY
ARG ARG_AWS_ACCESS_KEY_ID
ARG ARG_AWS_SECRET_ACCESS_KEY
RUN RAILS_MASTER_KEY=$ARG_RAILS_MASTER_KEY rails assets:precompile && \
  AWS_ACCESS_KEY_ID=$ARG_AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY=$ARG_AWS_SECRET_ACCESS_KEY aws s3 sync public s3://juniormesquitadandao/vaga-dev-sr/public

ARG ARG_DATABASE_URL
RUN DATABASE_URL=$ARG_DATABASE_URL RAILS_MASTER_KEY=$ARG_RAILS_MASTER_KEY rails db:create db:migrate
