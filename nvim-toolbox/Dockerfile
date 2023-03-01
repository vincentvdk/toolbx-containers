FROM vincentvdk/base:latest
LABEL com.github.containers.toolbox="true"

ARG NVIM_VERSION=0.8.0

RUN mkdir /opt/nvim /opt/config/nvim && \
    curl -OL https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/nvim.appimage && \
    mv nvim.appimage /opt/nvim && \
    chmod +x /opt/nvim/nvim.appimage

ENV XDG_CONFIG_HOME=/opt/config

COPY nvim /opt/config/nvim

# Packer plugin for NeoVim
RUN git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    ${XDG_CONFIG_HOME}/nvim/site/pack/packer/start/packer.nvim

RUN echo 'alias vim="/opt/nvim/nvim.appimage"' >> /opt/config/zsh/.zshrc
