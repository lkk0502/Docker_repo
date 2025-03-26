FROM alpine:latest

# 安裝必要工具：git, python3, repo 所需依賴，SSH 和 gpg
RUN apk update && \
    apk add --no-cache \
    git \
    python3 \
    py3-pip \
    bash \
    curl \
    openssh-client \
    gnupg \
    && rm -rf /var/cache/apk/*

# 安裝 repo 工具
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo && \
    chmod a+x /usr/local/bin/repo

ENV PYTHONPATH=/usr/lib/python3/dist-packages

# 複製 .gitconfig、.gittemplate 和 .ssh 檔案
COPY ./git/.gitconfig /root/.gitconfig
COPY ./git/.gittemplate /root/.gittemplate
COPY --chmod=600 ./ssh/ /root/.ssh/

# 設定權限並調整配置
RUN chmod 644 /root/.gitconfig /root/.gittemplate

# 複製並設置 .bashrc
COPY ./bash/.bashrc /root/.bashrc
RUN chmod 644 /root/.bashrc

# 設定工作目錄並確保權限
WORKDIR /repos
RUN chmod -R 777 /repos
