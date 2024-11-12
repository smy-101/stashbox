# .devcontainer/Dockerfile
FROM ruby:3.3.6

# 安装常用工具和依赖
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs npm && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# 安装 Rails 依赖
RUN gem install bundler

# 设置工作目录
WORKDIR /workspace

# 安装 Solargraph（Ruby 语言服务器）
RUN gem install solargraph

# 设置PATH
ENV PATH="/workspace/bin:${PATH}"

# 设置默认的Rails环境
ENV RAILS_ENV=development
