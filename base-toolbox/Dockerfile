FROM fedora:latest
LABEL com.github.containers.toolbox="true"

# -- Packages
RUN dnf install -y tmux passwd bash zsh fuse fuse-libs curl starship git unzip procps-ng ripgrep bat pgp-tools && dnf clean all

# -- Directories
RUN mkdir -p /opt/config/zsh/.antigen
RUN mkdir -p /opt/config/zsh
RUN mkdir -p /opt/bin
RUN mkdir -p /opt/config/fzf

# -- FZF
RUN git clone --depth 1 https://github.com/junegunn/fzf.git /opt/config/fzf && /opt/config/fzf/install --no-zsh

# -- ZSH
RUN curl -L git.io/antigen > /opt/config/zsh/.antigen/antigen.zsh
COPY zshrc /opt/config/zsh/.zshrc
COPY zsh_aliases /opt/config/

## -- Alacritty
#RUN mkdir -p /opt/config/alacritty
#COPY alacritty.yml /opt/config/alacritty/

# -- TMUX
RUN mkdir -p /opt/config/tmux
COPY tmux.conf /opt/config/tmux/tmux.conf

# -- binaries

# -- ENV
ENV ZDOTDIR=/opt/config/zsh
ENV FZF_BASE=/opt/config/fzf
ENV XDG_CONFIG_HOME=/opt/config
